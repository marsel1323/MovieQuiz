//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by mnabdrakhmanov on 19.12.2024.
//

import Foundation

final class QuestionFactory: QuestionFactoryProtocol {
    private var moviesLoader: MoviesLoading
    weak var delegate: QuestionFactoryDelegate?
    private var movies: [MostPopularMovie] = []
    
    init(moviesLoader: MoviesLoading, delegate: QuestionFactoryDelegate) {
        self.moviesLoader = moviesLoader
        self.delegate = delegate
    }
    
    func requestNextQuestion() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            let index = (0..<self.movies.count).randomElement() ?? 0
            
            guard let movie = self.movies[safe: index] else { return }
            
            var imageData: Data
            
            do {
                imageData = try Data(contentsOf: movie.resizedImageURL)
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.didFailToLoadData(with: NSError(
                        domain: "ImageLoading",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Не удалось загрузить изображение постера для фильма."]
                    ))
                }
                return
            }
            
            let randomRating = Float.random(in: 5.0...9.0).rounded(toPlaces: 1)
            let comparisonType = Bool.random() ? "больше" : "меньше"
            let text = "Рейтинг этого фильма \(comparisonType) чем \(randomRating)?"
            
            let rating = Float(movie.rating) ?? 0
            let correctAnswer = comparisonType == "больше" ? rating > randomRating : rating < randomRating
            
            let question = QuizQuestion(
                image: imageData,
                text: text,
                correctAnswer: correctAnswer
            )
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.delegate?.didReceiveNextQuestion(question: question)
            }
        }
    }
    
    func loadData() {
        moviesLoader.loadMovies { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let mostPopularMovies):
                    self.movies = mostPopularMovies.items
                    self.delegate?.didLoadDataFromServer()
                case .failure(let error):
                    self.delegate?.didFailToLoadData(with: error)
                }
            }
        }
    }
}
