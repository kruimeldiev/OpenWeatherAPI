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
            
            HStack {
                VStack(alignment: .center) {
                    Text("0")
                        .font(Font.largeTitle)
                        .foregroundColor(Color("FontColor"))
                    Text("Voelt als: ")
                        .foregroundColor(Color("FontColor"))
                }
                
                VStack {
                    Image(systemName: "arrow.2.circlepath")
                        .rotationEffect(Angle(degrees: 45))
                        .font(Font.largeTitle)
                        .foregroundColor(Color("FontColor"))
                    Text("Bewolkt")
                        .foregroundColor(Color("FontColor"))
                }
            }
        }
    }
}

struct WeerberichtLadenView_Previews: PreviewProvider {
    static var previews: some View {
        WeerberichtLadenView()
    }
}
