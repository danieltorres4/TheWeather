//
//  WeatherModelMapper.swift
//  TheWeather
//
//  Created by Iván Sánchez Torres on 27/03/23.
//

import Foundation

/// Mapper -> It maps the WeatherResponse to WeatherModel. This mapper will prepare every data in order to avoid doing operations in the MainView
struct WeatherModelMapper {
    func mapResponseDataModelToModel(dataModel: WeatherResponse) -> WeatherModel {
        /// Verifying if there is data in the weather array
        guard let weather = dataModel.weather.first else {
            return .empty
        }
        
        let temperature = dataModel.temperature
        
        /// Calculating the sunset and sunrise hours
        let sunset = dataModel.time.sunset.addingTimeInterval(dataModel.timezone - Double(TimeZone.current.secondsFromGMT()))
        let sunrise = dataModel.time.sunrise.addingTimeInterval(dataModel.timezone - Double(TimeZone.current.secondsFromGMT()))
        
        let country = dataModel.time.country
        
        return WeatherModel(city: dataModel.city, weather: weather.weather, description: "\(weather.description)", weatherIcon: URL(string: "https://openweathermap.org/img/wn/\(weather.weatherIcon)@2x.png"), temp: "\(Int(temperature.temp)) º", min: "\(Int(temperature.min)) º", max: "\(Int(temperature.max)) º", timezone: "\(Int(dataModel.timezone))", sunset: sunset, sunrise: sunrise, country: country, thermalSensation: "\(temperature.thermalSensation) º")
    }
}
