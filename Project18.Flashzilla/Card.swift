//
//  Card.swift
//  Project18.Flashzilla
//
//  Created by Fernando Jurado on 10/3/25.
//

import Foundation

struct Card: Codable, Identifiable, Hashable, Equatable{
    var id: UUID
    var prompt: String
    var answer: String
    static let example = Card(id: UUID(),prompt: "What is 2 + 2?", answer: "4")
    
    
}
