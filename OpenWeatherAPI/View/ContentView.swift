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
    
    var body: some View {
        
        ZStack{
            Color("Offwhite")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                
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
                .padding(.top)
                
                VStack(spacing: 40) {
                    HStack(spacing: 20) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.custom("SF Pro Text Heavy", size: 48))
                            .foregroundColor(Color("FontColor"))
                        Text(huidigeLokatie)
                            .font(.custom("SF Pro Text Heavy", size: 48))
                            .foregroundColor(Color("FontColor"))
                    }
                    Text(self.weerberichtVM.getDatum())
                }
                .padding(.vertical, 40)
                
                if self.weerberichtVM.dataLadenStatus == .loading {
                    WeerberichtLadenView()
                } else if self.weerberichtVM.dataLadenStatus == .success {
                    WeerberichtView(weerberichtVM: self.weerberichtVM)
                } else if self.weerberichtVM.dataLadenStatus == .failure {
                    Text(self.weerberichtVM.errorBericht)
                        .foregroundColor(Color("FontColor"))
                }
                
                VStack(spacing: 10) {
                    HStack {
                        Text("Lucht vochtigheid:")
                        Spacer()
                        Text("\(self.weerberichtVM.vochtigheid)%")
                    }
                    HStack {
                        Text("Luchtdruk:")
                        Spacer()
                        Text("\(self.weerberichtVM.luchtdruk) hPa")
                    }
                    HStack {
                        Text("Wind snelheid:")
                        Spacer()
                        Text(self.weerberichtVM.windSnelheid)
                    }
                    HStack {
                        Text("Wind richting:")
                        Spacer()
                        Text(self.weerberichtVM.windRichting)
                    }
                }
                .padding(40)
                .foregroundColor(Color("FontColor"))
                
                Spacer()
                
                Picker(selection: self.$weerberichtVM.tempUnit, label: Text("Selecteer unit:")) {
                    ForEach(TempUnit.allCases, id: \.self) { unit in
                        Text(unit.rawValue.capitalized)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 40)
                
            }
            .padding()
        }
        .onAppear {
            self.weerberichtVM.fetchWeerbericht(stadNaam: "Utrecht")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
