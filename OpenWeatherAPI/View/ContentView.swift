//
//  ContentView.swift
//  OpenWeatherAPI
//
//  Created by Casper Daris on 15/08/2020.
//  Copyright © 2020 Casper Daris. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var weerberichtVM = WeerberichtViewModel()
    
    @State private var zoekbalkText = ""
    
    var body: some View {
        
        VStack {
            HStack {
                TextField("Zoek op lokatie", text: $zoekbalkText, onCommit: {
                    self.weerberichtVM.fetchWeerbericht(stadNaam: self.zoekbalkText)
                })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    self.weerberichtVM.fetchWeerbericht(stadNaam: self.zoekbalkText)
                }) {Text("Zoek")}
            }
            Text("\(weerberichtVM.temperatuur)")
            Text("\(weerberichtVM.voelt_aan_als)")
            Text(weerberichtVM.errorBericht)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
