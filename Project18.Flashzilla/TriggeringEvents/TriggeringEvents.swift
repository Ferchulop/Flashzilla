//
//  TriggeringEvents.swift
//  Project18.Flashzilla
//
//  Created by Fernando Jurado on 3/3/25.
//

import SwiftUI

struct TriggeringEvents: View {
    // Se crea un Timer que se ejecuta cada segundo en el hilo principal, ejecutandose en modo comun(.common) permitiendo que esté activo mientras la app está en primer plano. Con .autoconnect empieza auto sin necesidad de activarlo manualmente
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    var body: some View {
       Text("")
        //.onReceive permite escuchar eventos cuando el temporizador emite un valor
            .onReceive(timer) { time in
                // al llegar a 5 el temporizador se detiene 
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                print("The time is now \(time)")
            }
                counter += 1
    }
    }
}

#Preview {
    TriggeringEvents()
}
