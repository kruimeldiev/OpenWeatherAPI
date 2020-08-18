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
        
        VStack {
            Text("\(self.weerberichtVM.temperatuur)")
            Text("\(self.weerberichtVM.voelt_aan_als)")
        }
        
    }
}

struct WeerberichtView_Previews: PreviewProvider {
    static var previews: some View {
        WeerberichtView(weerberichtVM: WeerberichtViewModel())
    }
}
