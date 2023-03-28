//
//  WeatherViewModel.swift
//  TheWeather
//
//  Created by Iván Sánchez Torres on 27/03/23.
//

import Foundation

final class WeatherViewModel: ObservableObject {
    @Published var weatherModel: WeatherModel = .empty
    private let weatherModelMapper: WeatherModelMapper = WeatherModelMapper()
    
    /// This method will do the HTTP petition to get the weather info of a city (parameter)
    func getWeatherInfo(city: String) async {
        guard let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=55822766946b065ad07b72bf3f07bc04&units=metric&lang=es") else { return }
        
        do {
            /// Petition
            async let (data, _) = try await URLSession.shared.data(from: weatherURL)
            /// Mapping to the data model
            let dataModel = try! await JSONDecoder().decode(WeatherResponse.self, from: data)
            
            print("DataModel: \(dataModel)")
            
            DispatchQueue.main.async {
                /// The data model will be passed to the mapper
                self.weatherModel = self.weatherModelMapper.mapResponseDataModelToModel(dataModel: dataModel)
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
}
