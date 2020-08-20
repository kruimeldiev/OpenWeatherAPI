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
            
            VStack {
                
                VStack {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .font(Font.largeTitle)
                            .foregroundColor(Color("FontColor"))
                            .padding()
                        Text(huidigeLokatie)
                            .font(Font.largeTitle)
                            .foregroundColor(Color("FontColor"))
                    }
                    Text("Hier komt de datum")
                }
                .padding(.vertical, 60)
                
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
                
                if self.weerberichtVM.dataLadenStatus == .loading {
                    WeerberichtLadenView()
                } else if self.weerberichtVM.dataLadenStatus == .success {
                    WeerberichtView(weerberichtVM: self.weerberichtVM)
                } else if self.weerberichtVM.dataLadenStatus == .failure {
                    Text(self.weerberichtVM.errorBericht)
                        .foregroundColor(Color("FontColor"))
                }
                
                VStack {
                    HStack {
                        Text("Lucht vochtigheid:")
                        Text("\(self.weerberichtVM.vochtigheid)%")
                    }
                    HStack {
                        Text("Luchtdruk:")
                        Text("\(self.weerberichtVM.luchtdruk) hPa")
                    }
                }
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
