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
    
    @Published var weerbericht: Weerbericht?
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
    
    var bewolking: Int {
        guard let bewolking = weerbericht?.clouds.all else {
            return 0
        }
        return Int(bewolking)
    }
    
    var luchtID: Int {
        guard let luchtID = weerbericht?.weather[0].id else {
            return 801
        }
        return luchtID
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
    
    var windSnelheid: Double {
        guard let windSnelheid = weerbericht?.wind.speed else {
            return 0
        }
        return windSnelheid
    }
    
    var windRichting: Int {
        guard let windRichting = weerbericht?.wind.deg else {
            return 0
        }
        return windRichting
    }
    
    var naam: String {
        guard let plaatsNaam = weerbericht?.name else {
            return "Onbekend"
        }
        return plaatsNaam
    }
    
    var land: String {
        guard let land = weerbericht?.sys.country else {
            return ""
        }
        return land
    }
    
    var tijdZone: Int {
        guard let tijdZone = weerbericht?.timezone else {
            return 0
        }
        return tijdZone
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
        
        // Aantal seconden om aan datum toe te voegen
        guard let seconden = self.weerbericht?.timezone else {
            return "Geen datum gevonden"
        }
        
        // Format maken om de datum in weer te geven
        let datumFormatter = DateFormatter()
        datumFormatter.dateFormat = "EEE d MMMM yyyy HH:mm:ss"
        datumFormatter.timeZone = TimeZone(secondsFromGMT: seconden)
        
        return datumFormatter.string(from: Date())
    }
    
    func getWeerIcoon(weerCode: Int, bewolking: Int, windsnelheid: Int) -> String {
        
        if (windSnelheid >= 10) {
            return "wind"
        } else if (bewolking >= 40 && weerCode > 799) {
            return "cloud"
        } else if (weerCode >= 200 && weerCode <= 202) {
            return "cloud.bolt.rain"
        } else if (weerCode >= 210 && weerCode <= 232) {
            return "cloud.bolt"
        } else if (weerCode >= 300 && weerCode <= 504) {
            return "cloud.rain"
        } else if (weerCode == 511) {
            return "cloud.hail"
        } else if (weerCode >= 520 && weerCode <= 531) {
            return "cloud.rain"
        } else if (weerCode >= 600 && weerCode <= 622) {
            return "cloud.snow"
        } else if (weerCode >= 701 && weerCode <= 781) {
            return "cloud.fog"
        } else {
            return "sun.max"
        }
        
    }
    
    func getWindrichtingCordinalDirection(windrichting: Int) -> String {
        
        if (windrichting >= 11 && windrichting < 34) {
            return "NNO"
        } else if (windrichting >= 34 && windrichting < 57) {
            return "NO"
        } else if (windrichting >= 57 && windrichting < 79) {
            return "ONO"
        } else if (windrichting >= 79 && windrichting < 102) {
            return "O"
        } else if (windrichting >= 102 && windrichting < 124) {
            return "OZO"
        } else if (windrichting >= 124 && windrichting < 147) {
            return "ZO"
        } else if (windrichting >= 147 && windrichting < 169) {
            return "ZZO"
        } else if (windrichting >= 169 && windrichting < 192) {
            return "Z"
        } else if (windrichting >= 192 && windrichting < 214) {
            return "ZZW"
        } else if (windrichting >= 214 && windrichting < 237) {
            return "ZW"
        } else if (windrichting >= 237 && windrichting < 259) {
            return "WZW"
        } else if (windrichting >= 259 && windrichting < 282) {
            return "W"
        } else if (windrichting >= 282 && windrichting < 304) {
            return "WNW"
        } else if (windrichting >= 304 && windrichting < 327) {
            return "NW"
        } else if (windrichting >= 327 && windrichting < 349) {
            return "NNW"
        } else {
            return "N"
        }
    }
}
