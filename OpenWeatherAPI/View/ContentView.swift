//
//  ContentView.swift
//  OpenWeatherAPI
//
//  Created by Casper Daris on 15/08/2020.
//  Copyright © 2020 Casper Daris. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var weerberichtVM = WeerberichtViewModel()
    
    @State var zoekbalkText = ""
    @State var huidigeLokatie = "Utrecht"
    
    @State var valueVoorToetsenbord: CGFloat = 0
    
    var body: some View {
        
        ZStack{
            Color("Offwhite")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 120) {
                
                Spacer()
                
                VStack {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .font(Font.largeTitle)
                            .foregroundColor(Color("FontColor"))
                        Text(huidigeLokatie)
                            .font(Font.largeTitle)
                            .foregroundColor(Color("FontColor"))
                    }
                    
                    Text("Hier komt de datum")
                }
                
                if self.weerberichtVM.dataLadenStatus == .loading {
                    Text("Data laden...")
                        .foregroundColor(Color("FontColor"))
                } else if self.weerberichtVM.dataLadenStatus == .success {
                    WeerberichtView(weerberichtVM: self.weerberichtVM)
                } else if self.weerberichtVM.dataLadenStatus == .failure {
                    Text(self.weerberichtVM.errorBericht)
                        .foregroundColor(Color("FontColor"))
                }
                
                HStack {
                    TextField("Zoek op lokatie", text: $zoekbalkText, onCommit: {
                        self.weerberichtVM.fetchWeerbericht(stadNaam: self.zoekbalkText)
                        self.huidigeLokatie = self.zoekbalkText
                    })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        self.weerberichtVM.fetchWeerbericht(stadNaam: self.zoekbalkText)
                        self.huidigeLokatie = self.zoekbalkText
                    }) {Text("Zoek")}
                }
                
                Spacer()
            }
            .padding()
        }
        // Standaard is de valueVoorToetsenbord 0, zodra deze waarde wordt verhoogd, gaat het gehele scherm omhoog
        .offset(y: -self.valueVoorToetsenbord)
        
        // Animatie toevoegen voor wanneer de offset van het scherm veranderd
        .animation(.spring())
        .onAppear {
            
            // Data van Utrecht laden bij het opstarten van de app
            self.weerberichtVM.fetchWeerbericht(stadNaam: "Utrecht")
            
            // Deze observer zorgt ervoor dat
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) {
                (noti) in
                self.valueVoorToetsenbord = 140
            }
            
            //
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) {
                (noti) in
                self.valueVoorToetsenbord = 0
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
