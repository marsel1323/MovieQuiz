//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by mnabdrakhmanov on 20.12.2024.
//

import UIKit

final class AlertPresenter {
    private weak var delegate: AlertPresenterDelegate?
    
    init(delegate: AlertPresenterDelegate) {
        self.delegate = delegate
    }
    
    func showAlert(alertModel: AlertModel) {
        guard let viewController = delegate?.viewControllerForAlertPresentation() else { return }
        
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: alertModel.buttonText,
            style: .default
        ) { _ in
            alertModel.completion()
        }
        
        alert.addAction(action)
        
        alert.view.accessibilityIdentifier = "Game results"
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
