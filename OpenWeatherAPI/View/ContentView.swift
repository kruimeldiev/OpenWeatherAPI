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
    
    @State var datum = ""
    
    var body: some View {
        
        ZStack{
            Color("Offwhite")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                
                HStack {
                    TextField("Zoek op lokatie", text: $zoekbalkText, onCommit: {
                        self.weerberichtVM.fetchWeerbericht(stadNaam: self.zoekbalkText)
                        self.huidigeLokatie = self.zoekbalkText
                        self.datum = self.weerberichtVM.getDatum()
                    })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        self.weerberichtVM.fetchWeerbericht(stadNaam: self.zoekbalkText)
                        self.huidigeLokatie = self.zoekbalkText
                        self.datum = self.weerberichtVM.getDatum()
                    }) {Text("Zoek")}.padding(.horizontal, 10)
                }
                .padding(.top)
                
                VStack(spacing: 40) {
                    HStack(spacing: 20) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.custom("SF Pro Text Heavy", size: 24))
                            .foregroundColor(Color("FontColor"))
                        Text(self.weerberichtVM.naam + ", " + self.weerberichtVM.land)
                            .font(.custom("SF Pro Text Heavy", size: 36))
                            .foregroundColor(Color("FontColor"))
                    }
                    Text(datum)
                }
                .padding(.vertical, 40)
                
                if self.weerberichtVM.dataLadenStatus == .loading {
                    WeerberichtLadenView()
                } else if self.weerberichtVM.dataLadenStatus == .success {
                    WeerberichtView(weerberichtVM: self.weerberichtVM)
                } else if self.weerberichtVM.dataLadenStatus == .failure {
                    WeerberichtLadenView()
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
                        Image(systemName: "location.circle")
                            .rotationEffect(Angle(degrees: Double(self.weerberichtVM.windRichting)))
                        Text(self.weerberichtVM.getWindrichtingCordinalDirection(windrichting: self.weerberichtVM.windRichting))
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
            self.datum = self.weerberichtVM.getDatum()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
