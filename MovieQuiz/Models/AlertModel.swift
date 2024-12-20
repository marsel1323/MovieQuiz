//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by mnabdrakhmanov on 20.12.2024.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: () -> Void
}
