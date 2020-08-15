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
    
    var body: some View {
        Text("\(weerberichtVM.temperatuur)")
            .onAppear() {
                self.weerberichtVM.fetchWeerbericht()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
