//
//  StatisticServiceProtocol.swift
//  MovieQuiz
//
//  Created by mnabdrakhmanov on 20.12.2024.
//

import Foundation

protocol StatisticServiceProtocol {
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: GameResult { get }
    
    func store(correct count: Int, total amount: Int)
}
