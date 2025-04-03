//
//  Card.swift
//  Project18.Flashzilla
//
//  Created by Fernando Jurado on 10/3/25.
//

import Foundation

struct Card: Codable {
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "What is 2 + 2?", answer: "4")
    
    
}
