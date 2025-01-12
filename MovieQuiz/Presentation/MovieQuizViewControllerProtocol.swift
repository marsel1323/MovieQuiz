//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by mnabdrakhmanov on 08.01.2025.
//

import UIKit

protocol MovieQuizViewControllerProtocol: AnyObject {
    func show(quiz step: QuizStepViewModel)
    func show(quiz result: QuizResultsViewModel)
    
    func highlightImageBorder(isCorrectAnswer: Bool)
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func setButtonsEnabled(isEnabled: Bool)
    
    func showNetworkError(message: String)
}
