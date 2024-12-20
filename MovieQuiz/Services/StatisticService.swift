//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by mnabdrakhmanov on 20.12.2024.
//

import Foundation

final class StatisticService: StatisticServiceProtocol {
    private let userDefaults: UserDefaults = .standard
    
    private enum Keys: String {
        case correct, total, bestGame, gamesCount
    }
    
    var totalAccuracy: Double {
        let correct = userDefaults.integer(forKey: Keys.correct.rawValue)
        let total = userDefaults.integer(forKey: Keys.total.rawValue)
        return total > 0 ? Double(correct) / Double(total) : 0
    }
    
    var gamesCount: Int {
        get {
            return userDefaults.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameResult {
        get {
            guard let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
                  let result = try? JSONDecoder().decode(GameResult.self, from: data) else {
                return .init(correct: 0, total: 0, date: Date())
            }
            return result
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Unable to save game result")
                return
            }
            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
    }
    
    func store(correct count: Int, total amount: Int) {
        let newResult = GameResult(correct: count, total: amount, date: Date())
        let correct = Keys.correct.rawValue
        let total = Keys.total.rawValue
        
        if newResult.isBetterThan(bestGame) {
            bestGame = newResult
        }
        
        let currentCorrect = userDefaults.integer(forKey: correct)
        let currentTotal = userDefaults.integer(forKey: total)
        
        userDefaults.set(currentCorrect + count, forKey: correct)
        userDefaults.set(currentTotal + amount, forKey: total)
        gamesCount += 1
    }
}
