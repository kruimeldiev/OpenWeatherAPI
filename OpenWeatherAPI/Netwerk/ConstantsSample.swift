//
//  ConstantsSample.swift
//  OpenWeatherAPI
//
//  Created by Casper Daris on 18/08/2020.
//  Copyright © 2020 Casper Daris. All rights reserved.
//

/*
    Dit bestand is een voorbeeld voor het COnstants.swift bestand
    Het Constants.swift bestand staat niet op GitHub, via deze sample kunnen andere developers zelf hun API key toevoegen
    Deze sample wordt verder niet gebruikt in de applicatie
 */

import Foundation

struct ConstantsSample {
    
    static let API_KEY = ""
    
    // Deze functie maakt een URL object van de API, de opgegeven stadNaam door de gebruiker en mijn persoonlijke API key
    static func getUrl(stadNaam: String) -> URL? {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=" + stadNaam + "&appid=" + API_KEY) else {
            return nil
        }
        return url
    }
    
}
