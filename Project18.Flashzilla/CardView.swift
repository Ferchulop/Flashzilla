//
//  CardView.swift
//  Project18.Flashzilla
//
//  Created by Fernando Jurado on 10/3/25.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @State private var offset = CGSize.zero
    @State private var isShowingAnswer = false
    let card: Card
    var removal: (() -> Void)? = nil
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    accessibilityDifferentiateWithoutColor ? .white : .white.opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    accessibilityDifferentiateWithoutColor ? nil :
                    RoundedRectangle(cornerRadius: 25)
                        .fill(offset.width > 0 ? .green : .red)
                    
                )
                .shadow(radius: 10)
            VStack {
                if accessibilityVoiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                        
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
            
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(offset.width / 5.0)) // Rota la carta en función del desplazamiento horizontal
        .offset(x: offset.width * 5) // Mueve la carta en el eje X
        .opacity(2 - Double(abs(offset.width / 50))) // Cambia la opacidad dependiendo del desplazamiento
        .accessibilityAddTraits(.isButton) // Indica que el componente se comporta como un botón en VoiceOver
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    
                }
                .onEnded { _ in
                    // Si el usuario no arrastró más de 100 puntos a la izq o der se ejecuta removal, si no vuelve a su posición original
                    if abs(offset.width) > 100 {
                        removal?()
                        
                    } else {
                        offset = .zero
                    }
                    
                }
            
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        // Genera un efecto de rebote al desplazar la card
        .animation(.bouncy, value: offset)
    }
}

#Preview {
    CardView(card:.example)
}
