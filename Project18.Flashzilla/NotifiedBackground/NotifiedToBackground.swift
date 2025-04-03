//
//  NotifiedToBackground.swift
//  Project18.Flashzilla
//
//  Created by Fernando Jurado on 8/3/25.
//

import SwiftUI

struct NotifiedToBackground: View {
    // Indica en qué estado se encuentra la escena de la app
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onChange(of: scenePhase) { oldPhase, newPhase in
                // La app está en primer plano y el usuario la está utilizando
                if newPhase == .active {
                    print("ACTIVE")
                // La app sigue en primer plano, pero no recibe interacciones directas( Ej: el usuario recibe una llamada o abre el centro de control)
                } else if newPhase == .inactive {
                    print("INACTIVE")
                // La app está en segundo plano o ha sido minimizada
                } else if newPhase == .background {
                    print("BACKGROUND")
                }
                
            }
    }
}

#Preview {
    NotifiedToBackground()
}
