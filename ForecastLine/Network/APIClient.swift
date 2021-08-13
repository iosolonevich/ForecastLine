//
//  APIClient.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import Foundation

final class APIClient {
    
    private let defaultSession = URLSession(configuration: .default)
    private let jsonDeserializer = SerializeHelper.shared.decoder
    
    func perform<T>(request: Request<T>) {
        
        guard let urlRequest = buildURLRequest(request: request) else {
            request.completion?(.failure(InvalidURLError()))
            return
        }
        
        let dataTask = defaultSession.dataTask(with: urlRequest) { data, response, error in
            self.handleResponse(data: data, response: response, error: error, request: request)
        }
        
        dataTask.resume()
    }
}

extension APIClient {
    
    private func buildURLRequest<T>(request: Request<T>) -> URLRequest? {
        
        guard let url = URL(string: request.url) else {
            return nil
        }
        
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
    
    private func handleResponse<T>(data: Data?, response: URLResponse?, error: Error?, request: Request<T>) {
        
        if let error = error {
            request.completion?(.failure(error))
            return
        }
        
        guard let response = response as? HTTPURLResponse else {
            request.completion?(.failure(MissingAPIResponse()))
            return
        }
        
        guard response.statusCode >= 200 && response.statusCode < 300 else {
            request.completion?(.failure(APIError(statusCode: response.statusCode, data: data)))
            return
        }
        
        serializeResponse(request: request, data: data)
    }
    
    private func serializeResponse<T>(request: Request<T>, data: Data?) {
        
        if let completion = request.completion as? ((Result<Empty, Error>) -> Void) {
            completion(.success(Empty()))
            return
        }
        
        guard let data = data else {
            request.completion?(.failure(MissingAPIData()))
            return
        }
        
//        if let niceString = data.prettyStringValue {
//            print(niceString)
//        }
        
        do {
            let decodedObject = try jsonDeserializer.decode(T.self, from: data)
            request.completion?(.success(decodedObject))
        } catch let error {
            request.completion?(.failure(error))
            return
        }
    }
}
