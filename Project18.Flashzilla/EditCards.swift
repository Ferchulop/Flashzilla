//
//  EditCards.swift
//  Project18.Flashzilla
//
//  Created by Fernando Jurado on 1/4/25.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    
    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add Card", action: addCard)
                    
                }
                Section {
                    ForEach(0..<cards.count, id: \.self) {  index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .onAppear(perform: loadData)
        }
    }
    func done() {
        dismiss()
        
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
        }
        func saveData() {
            if let data = try? JSONEncoder().encode(cards) {
                UserDefaults.standard.set(data, forKey: "cards")
            }
        }
        // Añade una nueva carta al array de cartas
        func addCard() {
            // Elimina espacios en blanco al principio y final de las cadenas de texto
            let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
            let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
            // Verifica si ambas cadenas no están vacías
            guard trimmedPrompt.isEmpty == false, trimmedAnswer.isEmpty == false else {
                return }
            // Crea la carta con los valores proporcionados
            let card = Card(id: UUID(),prompt: trimmedPrompt, answer: trimmedAnswer)
            cards.insert(card, at: 0)
            // CHALLENGE 1
            newAnswer = ""
            newPrompt = ""
            saveData()
            
        }
        
        
        func removeCards(at offsets: IndexSet) {
            cards.remove(atOffsets: offsets)
            saveData()
        }
        
    }




    


#Preview {
    EditCards()
}
