//
//  WeatherModel.swift
//  TheWeather
//
//  Created by Iván Sánchez Torres on 27/03/23.
//

import Foundation

struct WeatherModel {
    let city: String
    let weather: String
    let description: String
    let weatherIcon: URL?
    let temp: String
    let min: String
    let max: String
    let timezone: String
    let sunset: Date
    let sunrise: Date
    let country: String
    let thermalSensation: String
    
    static let empty: WeatherModel = .init(city: "No city", weather: "No weather", description: "No description", weatherIcon: nil, temp: "0 º", min: "0 º", max: "0 º", timezone: "0", sunset: .now, sunrise: .now, country: "No country", thermalSensation: "No Thermal Sensation")
}
