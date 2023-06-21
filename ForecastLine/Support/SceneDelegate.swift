//
//  SceneDelegate.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let initialController = setupInitialController()
        showInitialController(controller: initialController, at: windowScene)
    }
}

extension SceneDelegate {
    
    private func setupInitialController() -> UIViewController {
        let controller = LocationListCreator().getController()
        return UINavigationController(rootViewController: controller)
    }
    
    private func showInitialController(controller: UIViewController, at scene: UIWindowScene) {
        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
}
