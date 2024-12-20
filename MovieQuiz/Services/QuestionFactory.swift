//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by mnabdrakhmanov on 19.12.2024.
//

import Foundation

final class QuestionFactory: QuestionFactoryProtocol {
    weak var delegate: QuestionFactoryDelegate?
    private var shownQuestionsIndexes: Set<Int> = []
    
    init(delegate: QuestionFactoryDelegate) {
        self.delegate = delegate
    }
    
    private let questions: [QuizQuestion] = [
        QuizQuestion(
            image: "The Godfather",
            text: "Рейтинг этого фильма больше чем 6?",
            realRating: 9.2,
            correctAnswer: true
        ),
        QuizQuestion(
            image: "The Dark Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            realRating: 9,
            correctAnswer: true
        ),
        QuizQuestion(
            image: "Kill Bill",
            text: "Рейтинг этого фильма больше чем 6?",
            realRating: 8.1,
            correctAnswer: true
        ),
        QuizQuestion(
            image: "The Avengers",
            text: "Рейтинг этого фильма больше чем 6?",
            realRating: 8,
            correctAnswer: true
        ),
        QuizQuestion(
            image: "Deadpool",
            text: "Рейтинг этого фильма больше чем 6?",
            realRating: 8,
            correctAnswer: true
        ),
        QuizQuestion(
            image: "The Green Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            realRating: 6.6,
            correctAnswer: true
        ),
        QuizQuestion(
            image: "Old",
            text: "Рейтинг этого фильма больше чем 6?",
            realRating: 5.8,
            correctAnswer: false
        ),
        QuizQuestion(
            image: "The Ice Age Adventures of Buck Wild",
            text: "Рейтинг этого фильма больше чем 6?",
            realRating: 4.3,
            correctAnswer: false
        ),
        QuizQuestion(
            image: "Tesla",
            text: "Рейтинг этого фильма больше чем 6?",
            realRating: 5.1,
            correctAnswer: false
        ),
        QuizQuestion(
            image: "Vivarium",
            text: "Рейтинг этого фильма больше чем 6?",
            realRating: 5.8,
            correctAnswer: false
        )
    ]
    
    func requestNextQuestion() {
        let availableIndexes = (0..<questions.count).filter { !shownQuestionsIndexes.contains($0) }
        
        if availableIndexes.isEmpty {
            shownQuestionsIndexes.removeAll()
            requestNextQuestion()
            return
        }
        
        guard let index = availableIndexes.randomElement() else {
            delegate?.didReceiveNextQuestion(question: nil)
            return
        }
        
        shownQuestionsIndexes.insert(index)
        
        let question = questions[safe: index]
        delegate?.didReceiveNextQuestion(question: question)
    }
}
