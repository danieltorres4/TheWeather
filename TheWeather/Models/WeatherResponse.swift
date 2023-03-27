//
//  WeatherResponse.swift
//  TheWeather
//
//  Created by Iván Sánchez Torres on 27/03/23.
//

import Foundation

struct WeatherResponse: Decodable {
    let city: String
    let timezone: Double
    let weather: [Weather]
    let temperature: Temperature
    let time: TimeModel
    
    enum CodingKeys: String, CodingKey {
        case city = "name"
        case timezone
        case weather
        case temperature = "main"
        case time = "sys"
    }
}
struct Weather: Decodable {
    let weather: String
    let description: String
    let weatherIcon: String
    
    enum CodingKeys: String, CodingKey {
        case weather = "main"
        case description
        case weatherIcon = "icon"
    }
}

struct Temperature: Decodable {
    let temp: Double
    let thermalSensation: Double
    let min: Double
    let max: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case thermalSensation = "feels_like"
        case min = "temp_min"
        case max = "temp_max"
    }
}

struct TimeModel: Decodable {
    let sunset: Date
    let sunrise: Date
    let country: String
}
