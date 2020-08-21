//
//  WeerberichtLadenView.swift
//  OpenWeatherAPI
//
//  Created by Casper Daris on 20/08/2020.
//  Copyright © 2020 Casper Daris. All rights reserved.
//

import SwiftUI

struct WeerberichtLadenView: View {
    
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
                    Text("N/A")
                        .font(.custom("SF Pro Text Heavy", size: 64))
                        .foregroundColor(Color("FontColor"))
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Image(systemName: "questionmark.circle")
                        .font(.custom("SF Pro Text Heavy", size: 64))
                        .foregroundColor(Color("FontColor"))
                        .padding(.horizontal)
                }
                
                HStack {
                    Text("Voelt als: N/A")
                        .font(.custom("SF Pro Text Regular", size: 16))
                        .foregroundColor(Color("FontColor"))
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Text("N/A")
                        .font(.custom("SF Pro Text Regular", size: 16))
                        .foregroundColor(Color("FontColor"))
                        .padding(.horizontal)
                }
            }
            .padding()
        }
    }
}

struct WeerberichtLadenView_Previews: PreviewProvider {
    static var previews: some View {
        WeerberichtLadenView()
    }
}
