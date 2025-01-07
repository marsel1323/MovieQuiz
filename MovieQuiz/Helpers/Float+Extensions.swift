//
//  Float+Extensions.swift
//  MovieQuiz
//
//  Created by mnabdrakhmanov on 07.01.2025.
//

import Foundation

extension Float {
    /// Округление до указанного количества знаков после запятой
    func rounded(toPlaces places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
