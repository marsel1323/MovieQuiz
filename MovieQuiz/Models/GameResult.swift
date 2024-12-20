//
//  GameResult.swift
//  MovieQuiz
//
//  Created by mnabdrakhmanov on 20.12.2024.
//

import Foundation

struct GameResult: Codable {
    let correct: Int
    let total: Int
    let date: Date
    
    func isBetterThan(_ another: GameResult) -> Bool {
        return correct > another.correct
    }
}
