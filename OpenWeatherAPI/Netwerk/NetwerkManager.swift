//
//  NetwerkManager.swift
//  OpenWeatherAPI
//
//  Created by Casper Daris on 15/08/2020.
//  Copyright © 2020 Casper Daris. All rights reserved.
//

import Foundation

enum NetwerkFout: Error {
    case badUrl
    case noData
    case decodingError
}

class NetwerkManager {
    
    func getWeather(stadNaam: String, completion: @escaping (Result<Weerbericht?, NetwerkFout>) -> ()) {
        
        // URL ophalen met de input van gebruiker, else badUrl error terug sturen
        guard let url = Constants.getUrl(stadNaam: stadNaam) else {
            return completion(.failure(.badUrl))
        }
        
        // DataTask beginnen
        URLSession.shared.dataTask(with: url) {data, response, error in
            
            // data object maken zolang de error leeg is, else noData error terug sturen
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            // JSON data decoden naar een Weerbericht object
            // Bij success een weerbericht object terug geven, else een decodingError terug sturen
            let weerBericht = try? JSONDecoder().decode(Weerbericht.self, from: data)
            DispatchQueue.main.async {
                if let weerBericht = weerBericht {
                    completion(.success(weerBericht.self))
                } else {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
