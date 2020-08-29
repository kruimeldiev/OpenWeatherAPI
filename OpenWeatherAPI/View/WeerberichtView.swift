//
//  WeerberichtView.swift
//  OpenWeatherAPI
//
//  Created by Casper Daris on 18/08/2020.
//  Copyright © 2020 Casper Daris. All rights reserved.
//

import SwiftUI

struct WeerberichtView: View {
    
    @ObservedObject var weerberichtVM: WeerberichtViewModel
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height / 5)
                .cornerRadius(20)
                .foregroundColor(Color("Offwhite"))
                .shadow(color: Color(.black).opacity(0.1), radius: 8, x: 8, y: 8)
                .shadow(color: Color(.white), radius: 8, x: -8, y: -8)
            
            VStack(spacing: 30) {
                HStack {
                    Text(self.weerberichtVM.temperatuur)
                        .font(.custom("SF Pro Text Heavy", size: 64))
                        .foregroundColor(Color("FontColor"))
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Image(systemName: self.weerberichtVM.getWeerIcoon(weerCode: self.weerberichtVM.luchtID, bewolking: self.weerberichtVM.bewolking, windsnelheid: Int(self.weerberichtVM.windSnelheid)))
                        .font(.custom("SF Pro Text Heavy", size: 64))
                        .foregroundColor(Color("FontColor"))
                        .padding(.horizontal)
                }
                
                HStack {
                    Text("Voelt als: \(self.weerberichtVM.voelt_aan_als)")
                        .font(.custom("SF Pro Text Regular", size: 16))
                        .foregroundColor(Color("FontColor"))
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Text(self.weerberichtVM.luchtBeschrijving.capitalized)
                        .font(.custom("SF Pro Text Regular", size: 16))
                        .foregroundColor(Color("FontColor"))
                        .padding(.horizontal)
                }
            }
            .padding()
        }
    }
}

struct WeerberichtView_Previews: PreviewProvider {
    static var previews: some View {
        WeerberichtView(weerberichtVM: WeerberichtViewModel())
    }
}
