//
//  SpecificAccessibility.swift
//  Project18.Flashzilla
//
//  Created by Fernando Jurado on 9/3/25.
//

import SwiftUI

/// 1. UTILIZA LA FUNC REALIZADA
/// Si la opción Reduce Motion está activada en los ajustes de accesibilidad del iPhone, ejecuta el código sin animación. Si no, usa withAnimation para aplicar la animación
func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body:() throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

struct SpecificAccessibility: View {
    /* Si la opción "Diferenciar sin color" está activada en Accesibilidad, se añade un icono de check para reforzar el mensaje visualmente en lugar de solo usar el color.*/
    /// Básicamente, mejora la accesibilidad para personas con daltonismo o dificultad para diferenciar colores
    //@Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    
    /*Si la opción "Reducir Movimiento" está activada en Accesibilidad, significa que prefiere menos animaciones o efectos de movimiento para evitar mareos o molestias.*/
    /// Básicamente evita mareos o molestias en personas sensibles al movimiento
    
    @Environment(\.accessibilityReduceMotion) var accessibilityReduceMotion
    @State private var scale = 1.0
    
    /*Si la opción "Reducir transpariencia" está activada en Accesibilidad  Puedes usar fondos sólidos en lugar de translúcidos para mejorar la legibilidad. */
    /// Básicamente mejora la legibilidad del contenido para el usuario
    @Environment(\.accessibilityReduceTransparency) var accessibilityReduceTransparency
    var body: some View {
        /// Ejemplo con: accessibilityDifferentiateWithoutColor
        /*HStack {
         if accessibilityDifferentiateWithoutColor {
         Image(systemName: "checkmark.circle")
         }
         Text("Success")
         }
         .padding()
         .background(accessibilityDifferentiateWithoutColor ? .black : .green)
         .foregroundStyle(.white)
         .clipShape(.capsule)*/
        /// Ejemplo con: accessibilityReduceMotion
        /*Button("Hello World!") {
            /*if accessibilityReduceMotion {
                scale *= 1.5
            } else {
                withAnimation {
                    scale *= 1.5
                }
            }*/
        /// 1. UTILIZA LA FUNC REALIZADA
            withOptionalAnimation {
                scale *= 1.5
            }
        }
        .scaleEffect(scale)*/
       /// Ejemplo con: accessibilityReduceTransparency
        Text("Hello World!")
            .padding()
            .background(accessibilityReduceTransparency ? .black  : .black.opacity(0.5))
            .foregroundStyle(.white)
            .clipShape(.capsule)
            
    }
}

#Preview {
    SpecificAccessibility()
}
