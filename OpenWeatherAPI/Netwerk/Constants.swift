//
//  Constants.swift
//  OpenWeatherAPI
//
//  Created by Casper Daris on 15/08/2020.
//  Copyright © 2020 Casper Daris. All rights reserved.
//

import Foundation

struct Constants {
    
    static let API_KEY = "ca49962d7066403dd1d797b9d9e2b0e2"
    
    static func getUrl(stadNaam: String) -> URL? {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=" + stadNaam + "&appid=" + API_KEY) else {
            return nil
        }
        return url
    }
    
}
