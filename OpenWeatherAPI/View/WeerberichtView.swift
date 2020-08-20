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
    @State var weerIcoon = "cloud"
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height / 5)
                .cornerRadius(20)
                .foregroundColor(Color("Offwhite"))
                .shadow(color: Color(.black).opacity(0.1), radius: 8, x: 8, y: 8)
                .shadow(color: Color(.white), radius: 8, x: -8, y: -8)
            
            HStack {
                VStack {
                    Text("\(self.weerberichtVM.temperatuur)")
                        .font(Font.largeTitle)
                        .foregroundColor(Color("FontColor"))
                    Text("Voelt aan als: \(self.weerberichtVM.voelt_aan_als)")
                        .foregroundColor(Color("FontColor"))
                }
                
                VStack {
                    Image(systemName: weerIcoon)
                        .font(Font.largeTitle)
                        .foregroundColor(Color("FontColor"))
                    Text("Bewolkt")
                        .foregroundColor(Color("FontColor"))
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
