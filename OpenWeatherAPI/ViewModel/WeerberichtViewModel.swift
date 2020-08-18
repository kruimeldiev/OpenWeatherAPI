//
//  WeerberichtViewModel.swift
//  OpenWeatherAPI
//
//  Created by Casper Daris on 15/08/2020.
//  Copyright © 2020 Casper Daris. All rights reserved.
//

import Foundation

enum DataLadenStatus {
    case none
    case loading
    case success
    case failure
}

class WeerberichtViewModel: ObservableObject {
    
    @Published private var weerbericht: Weerbericht?
    @Published var errorBericht = ""
    @Published var dataLadenStatus: DataLadenStatus = .none
    
    
    
    
    // WAAROM HEB IK HIER EEN GUARD STATEMENT??
    // Ook even kijken of ik de else statement kan verkorten!! (: ?)
    var temperatuur: Double {
        guard let temperatuur = weerbericht?.main.temp else {
            return 0.0
        }
        return temperatuur
    }
    
    var voelt_aan_als: Double {
        guard let voelt_aan_als = weerbericht?.main.feels_like else {
            return 0.0
        }
        return voelt_aan_als
    }
    
    var temp_min: Double {
        guard let temp_min = weerbericht?.main.temp_min else {
            return 0.0
        }
        return temp_min
    }
    
    var temp_max: Double {
        guard let temp_max = weerbericht?.main.temp_max else {
            return 0.0
        }
        return temp_max
    }
    
    var luchtdruk: Int {
        guard let luchtdruk = weerbericht?.main.pressure else {
            return 0
        }
        return luchtdruk
    }
    
    var vochtigheid: Int {
        guard let vochtigheid = weerbericht?.main.pressure else {
            return 0
        }
        return vochtigheid
    }
    
    func fetchWeerbericht(stadNaam: String) {
        
        // Deze stadNaam.escaped() zorgt ervoor dat de spaties van de input van de gebruiker worden omgezet naar %20 zodat de URL werkt (zie: StringExtension)
        guard let stadNaam = stadNaam.escaped() else {
            self.errorBericht = "Ingevoerde lokatie onbekend"
            return
        }
        
        self.dataLadenStatus = .loading
        
        NetwerkManager().getWeather(stadNaam: stadNaam) { result in
            switch result {
            case .success(let weerbericht):
                self.weerbericht = weerbericht
                self.dataLadenStatus = .success
            case .failure(_ ):
                self.errorBericht = "Niet mogenlijk om het weer te tonen"
                self.dataLadenStatus = .failure
                self.weerbericht = nil
            }
        }
    }
}
