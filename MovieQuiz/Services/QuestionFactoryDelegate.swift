//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by mnabdrakhmanov on 20.12.2024.
//

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
}
