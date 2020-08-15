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
    
    func fetchWeerbericht(stadNaam: String) {
        
        // Deze stadNaam.escaped() zorgt ervoor dat de spaties van de input van de gebruiker worden omgezet naar %20 zodat de URL werkt (zie: StringExtension)
        guard let stadNaam = stadNaam.escaped() else {
            fatalError("URL escaping error")
        }
        
        NetwerkManager().getWeather(stadNaam: stadNaam) { result in
            switch result {
            case .success(let weerbericht):
                self.weerbericht = weerbericht
            case .failure(_ ):
                print("error")
            }
        }
        
    }
    
}
