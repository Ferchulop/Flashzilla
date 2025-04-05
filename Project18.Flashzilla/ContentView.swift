//
//  ContentView.swift
//  Project18.Flashzilla
//
//  Created by Fernando Jurado on 2/3/25.
//

import SwiftUI
// Este metodo se utiliza para apilar vistas de forma escalonada en el eje Y
extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}


struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @Environment(\.scenePhase) var scenePhase
    @State private var showingEditScreen = false
    @State private var isActive = true
    @State private var cards = [Card]()
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack{
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                ZStack {
                    // CHALLENGE 3 
                    ForEach(Array(cards.enumerated()), id: \.element) { success in
                        CardView(card: success.element) { reinsert in
                            withAnimation {
                                removeCard(at: success.offset, reinsert: reinsert)
                            }
                        }
                        .stacked(at: success.offset, in: cards.count)
                        .allowsHitTesting(success.offset == cards.count - 1)
                        .accessibilityHidden(success.offset < cards.count  - 1)
                    }
                }
                // Evita que los usuarios interactúen con las cartas cuando el temporizador ha llegado a cero.(Sí es + que 0 habilita el toque en la carta, si no lo deshabilita)
                .allowsHitTesting(timeRemaining > 0)
                .padding()
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
            }
            VStack {
                HStack {
                    
                    Spacer()
                    
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                        
                        
                    }
                }
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            // Si accessibilityDifferentiateWithoutColor está habilitado muestra...
            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1, reinsert: false)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1, reinsert: false)
                            }
                        } label: {
                            
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                    
                    
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else  { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
            
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
                
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCards.init)
        .onAppear(perform: resetCards)
        
    }
    
    // Funcion para quitar la carta que tocas en la pila
    func removeCard(at index: Int, reinsert:Bool) {
        
        guard index >= 0 else { return }
        
        if cards.isEmpty {
            isActive = false
        }
        if reinsert {
            cards.move(fromOffsets: IndexSet(integer: index), toOffset: 0)
        } else {
            cards.remove(at:index)
        }
}
// Funcion para resetear todas las cartas y utilizarlo en el boton "START AGAIN"
func resetCards() {
    timeRemaining = 100
    isActive = true
    loadData()
    
}
func loadData() {
    if let data = UserDefaults.standard.data(forKey: "cards") {
        if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
            cards = decoded
        }
    }
}
}

#Preview {
    ContentView()
}
