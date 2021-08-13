//
//  PrivacyController.swift
//  ForecastLine
//
//  Created by alex on 24.07.2021.
//

import UIKit

class PrivacyController: UIViewController {

    private let viewModel: PrivacyViewModel
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.contentInsetAdjustmentBehavior = .never
        return textView
    }()
    
    init(viewModel: PrivacyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        textView.attributedText = viewModel.getPrivacyContent()
        view.addSubview(textView, anchors: [ .leading(view.leadingAnchor), .trailing(view.trailingAnchor), .bottom(view.bottomAnchor), .top(view.topAnchor, 55) ])
    }
}
