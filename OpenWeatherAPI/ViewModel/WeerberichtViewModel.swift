//
//  WeerberichtViewModel.swift
//  OpenWeatherAPI
//
//  Created by Casper Daris on 15/08/2020.
//  Copyright © 2020 Casper Daris. All rights reserved.
//

import Foundation

class WeerberichtViewModel: ObservableObject {
    
    @Published private var weerbericht: Weerbericht?
    
    var temperatuur: Double {
        guard let temperatuur = weerbericht?.main.temp else {
            return 0.0
        }
        return temperatuur
    }
    
    func fetchWeerbericht() {
        
        NetwerkManager().getWeather(stadNaam: "utrecht") { result in
            switch result {
            case .success(let weerbericht):
                DispatchQueue.main.async {
                    self.weerbericht = weerbericht
                }
            case .failure(_ ):
                print("error")
            }
        }
        
    }
    
}
