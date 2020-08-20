//
//  Extensions.swift
//  OpenWeatherAPI
//
//  Created by Casper Daris on 15/08/2020.
//  Copyright © 2020 Casper Daris. All rights reserved.
//

import Foundation

extension String {
    
    // Deze escaped functie zorgt ervoor dat spaties binnen een String worden omgezet naar %20, zodat deze String gebruikt kan worden voor een URL
    func escaped() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
}

extension Double {
    
    // Deze functie berekend de kelvin waarde van temperatuur (uit de JSON) om naar fahrenheit
    func toFahrenheit() -> Double {
        let kelvin = Measurement<UnitTemperature>(value: self, unit: .kelvin)
        let fahrenheit = kelvin.converted(to: .fahrenheit)
        return fahrenheit.value
    }
    
    // Deze functie berekend de kelvin waarde van temperatuur (uit de JSON) om naar celsius
    func toCelsius() -> Double {
        let kelvin = Measurement<UnitTemperature>(value: self, unit: .kelvin)
        let celsius = kelvin.converted(to: .celsius)
        return celsius.value
    }
}
