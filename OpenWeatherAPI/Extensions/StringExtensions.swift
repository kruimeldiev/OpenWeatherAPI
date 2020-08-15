//
//  StringExtensions.swift
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
