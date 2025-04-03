//
//  allowsHitTesting.swift
//  Project18.Flashzilla
//
//  Created by Fernando Jurado on 3/3/25.
//

import SwiftUI

struct allowsHitTesting: View {
    var body: some View {
        // En esta demo hacemos uso de .contentShape(.rect) para recrear la posibilidad de pulsar el gesto en cualquier sitio que se desee siendo efectivo este mismo entre el texto: "Tap Me!" y "NOOOW"
        VStack {
            Text("Tap Me!")
             Spacer()
                .frame(height: 100)
            
            Text("NOOOW")
        }
        .contentShape(.rect)
        .onTapGesture {
            print("VStack tapped!")
        }
        // Coloco elementos encima uno del otro con respuestas a gestos.
        /*ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                print("Rectangle tapped!")
                    
                }
                Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
            //  Ampliar la zona interactiva de una vista sin cambiar su apariencia.Mejorar la usabilidad si la forma es pequeña o difícil de tocar.Garantiza que toda el área del frame sea interactiva, útil en diseños donde los elementos deben responder en una región mayor.
                .contentShape(.rect)
                .onTapGesture {
                    print("Circle tapped!")
                    
                }
                //  Ignorar interacciones en una vista sin ocultarla.Permitir que los toques pasen a las vistas de abajo, útil en superposiciones decorativas.Evitar bloqueos accidentales en la UI cuando algo está encima de un botón o enlace.
                .allowsHitTesting(false)
                
            
        }*/
    }
}

#Preview {
    allowsHitTesting()
}
