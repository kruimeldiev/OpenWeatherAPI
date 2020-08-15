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
        
        guard let url = Constants.getUrl(stadNaam: stadNaam) else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let weerBericht = try? JSONDecoder().decode(Weerbericht.self, from: data)
            if let weerBericht = weerBericht {
                completion(.success(weerBericht.self))
            } else {
                completion(.failure(.decodingError))
            }
            
        }.resume()
        
    }
    
}
