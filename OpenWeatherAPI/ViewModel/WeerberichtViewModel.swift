//
//  WeerberichtViewModel.swift
//  OpenWeatherAPI
//
//  Created by Casper Daris on 15/08/2020.
//  Copyright © 2020 Casper Daris. All rights reserved.
//

import Foundation

enum DataLadenStatus {
    case loading
    case success
    case failure
}

enum TempUnit: String, CaseIterable {
    case fahrenheit
    case celsius
}

class WeerberichtViewModel: ObservableObject {
    
    @Published private var weerbericht: Weerbericht?
    @Published var errorBericht = ""
    @Published var dataLadenStatus: DataLadenStatus = .loading
    @Published var tempUnit: TempUnit = .celsius
    
    var temperatuur: String {
        guard let temperatuur = weerbericht?.main.temp else {
            return "N/A"
        }
        switch tempUnit {
        case .fahrenheit:
            return String(format: "%.0f °F", temperatuur.toFahrenheit())
        case .celsius:
            return String(format: "%.0f °C", temperatuur.toCelsius())
        }
    }
    
    var voelt_aan_als: String {
        guard let voelt_aan_als = weerbericht?.main.feels_like else {
            return "N/A"
        }
        switch tempUnit {
        case .fahrenheit:
            return String(format: "%.0f °F", voelt_aan_als.toFahrenheit())
        case .celsius:
            return String(format: "%.0f °C", voelt_aan_als.toCelsius())
        }
    }
    
    var temp_min: String {
        guard let temp_min = weerbericht?.main.temp_min else {
            return "N/A"
        }
        switch tempUnit {
        case .fahrenheit:
            return String(format: "%.0f °F", temp_min.toFahrenheit())
        case .celsius:
            return String(format: "%.0f °C", temp_min.toCelsius())
        }
    }
    
    var temp_max: String {
        guard let temp_max = weerbericht?.main.temp_max else {
            return "N/A"
        }
        switch tempUnit {
        case .fahrenheit:
            return String(format: "%.0f °F", temp_max.toFahrenheit())
        case .celsius:
            return String(format: "%.0f °C", temp_max.toCelsius())
        }
    }
    
    var luchtdruk: String {
        guard let luchtdruk = weerbericht?.main.pressure else {
            return "N/A"
        }
        return String(luchtdruk)
    }
    
    var vochtigheid: String {
        guard let vochtigheid = weerbericht?.main.humidity else {
            return "N/A"
        }
        return String(vochtigheid)
    }
    
    var luchtStatus: String {
        guard let luchtStatus = weerbericht?.weather[0].main else {
            return "N/A"
        }
        return String(luchtStatus)
    }
    
    var luchtBeschrijving: String {
        guard let luchtBeschrijving = weerbericht?.weather[0].description else {
            return "N/A"
        }
        return String(luchtBeschrijving)
    }
    
    var windSnelheid: String {
        guard let windSnelheid = weerbericht?.wind.speed else {
            return "N/A"
        }
        return String("\(windSnelheid) m/s")
    }
    
    var windRichting: String {
        guard let windRichting = weerbericht?.wind.deg else {
            return "N/A"
        }
        return String(windRichting)
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
    
    func getDatum() -> String {
        let datumFormatter = DateFormatter()
        datumFormatter.dateFormat = "EEE d MMMM yyyy HH:mm:ss"
        return datumFormatter.string(from: Date())
    }
}
