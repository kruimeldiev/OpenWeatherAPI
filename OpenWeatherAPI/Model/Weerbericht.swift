//
//  Weerbericht.swift
//  OpenWeatherAPI
//
//  Created by Casper Daris on 15/08/2020.
//  Copyright © 2020 Casper Daris. All rights reserved.
//

import Foundation

struct Weerbericht: Decodable {
    let main: Temperatuur
    let weather: [LuchtStatus]
    let clouds: Bewolking
    let wind: Wind
    let sys: Land
    let timezone: Int
    let name: String
}

struct Temperatuur: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Bewolking: Decodable {
    let all: Int
}

struct LuchtStatus: Decodable {
    let id: Int
    let main: String
    let description: String
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
}

struct Land: Decodable {
    let country: String
}
