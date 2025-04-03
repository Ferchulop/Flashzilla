//
//  onTap.swift
//  Project18.Flashzilla
//
//  Created by Fernando Jurado on 2/3/25.
//

import SwiftUI

struct onTap: View {
    // Usado para círculo(rotar y escalar)
    @State private var offset = CGSize.zero // Se usa para restablecer el desplazamiento cuando el usuario termina de arrastrar el círculo a la posición original del círculo en pantalla
   
    @State private var isDragging = false
    
    
    // Usado para escalar el efecto:
   /* @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0*/
    // Usado para rotar el efecto
    // Propiedades que representan un ángulo de 0 grados
    /*@State private var currentAmount = Angle.zero
    @State private var finalAmount = Angle.zero*/
    var body: some View {
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        /// GESTOS DE MANTENER PRESIONADO O PRESIONAR
        // Presiona dos veces para realizar accion:
            /*.onTapGesture(count: 2){
            print("Double tapped!")
            }*/
        // Manten presionado para realizar accion:
        // Puedes personalizar su duración:
            /*.onLongPressGesture(minimumDuration: 2) {
                print("Long pressed!")
       // onPressing detecta cuando la pulsacion esta siendo efectiva y cuando no
            } onPressingChanged: { inProgress in
                print("In Progress: \(inProgress)")
            }*/
        /// ESCALA EL ELEMENTO DE MENOR A MAYOR O DE MAYOR A MENOR
        //  Ajusta el tamaño de la vista en función del valor proporcionado.
            /*.scaleEffect(finalAmount + currentAmount)
            .gesture(
                // MagnifyGesture reconocerá los pellizcos en el dispositivo
                MagnifyGesture()
                // El gesto cambia
                    .onChanged { value in
                        currentAmount = value.magnification - 1
                        
                    }
                // El gesto termina en la posición deseada
                    .onEnded { value in
                       finalAmount += currentAmount
                        currentAmount = 0
                    }
            )*/
        /// ELEMENTO PARA ROTAR
        // Rota el valor proporcionado:
        // Proporciona al elemento la posibilidad de rotar con los valores proporcionados
            /*.rotationEffect(currentAmount + finalAmount)
            .gesture(
                // Gesto que reconoce la rotación del elemento
                RotateGesture()
                // El gesto cambia
                    .onChanged { value in
                        currentAmount = value.rotation
                    }
                // El gesto termina
                    .onEnded { value in
                        finalAmount += currentAmount
                        currentAmount = .zero
                    }
        )*/
        /// CIRCULO QUE ROTA Y AUMENTA, COMBINACIÓN DE EFECTOS
        //  DragGesture: Es un gesto que detecta el movimiento del dedo del usuario sobre la pantalla y nos proporciona información como:
        // value.translation: La distancia que el dedo ha recorrido desde que comenzó el gesto.
        
        let dragGesture = DragGesture()
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { value in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }
        // Es un gesto que se activa cuando el usuario mantiene presionado un elemento por un tiempo determinado.
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }
        let combined = pressGesture.sequenced(before: dragGesture)
        Circle()
            .fill(.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined) // Asigna el gesto combinado (pulsación larga + arrastre).
    }
}

#Preview {
    onTap()
}
