//
//  CityWeatherDetails.swift
//  TheWeather
//
//  Created by Iván Sánchez Torres on 27/03/23.
//

import SwiftUI

struct CityWeatherDetails: View {
    @StateObject private var weatherViewModel = WeatherViewModel()
    @State var city = ""
    //var cityToSearch: String
    
    var body: some View {
        NavigationView {
            ZStack {
                
                VStack {
                    Text(weatherViewModel.weatherModel.city)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                    
                    Label(weatherViewModel.weatherModel.country, systemImage: "globe.americas.fill")
                        .symbolRenderingMode(.multicolor)
                        .foregroundColor(.white)
                    
                    Text(weatherViewModel.weatherModel.description.capitalizingFirstLetter())
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.bottom, 8)
                    
                    HStack {
                        if let iconURL = weatherViewModel.weatherModel.weatherIcon {
                            AsyncImage(url: iconURL) { image in
                                image
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        
                        Text(weatherViewModel.weatherModel.temp)
                            .font(.title)
                                .foregroundColor(.white)
                    }
                    .padding(.top, -20)
                    
                    VStack {
                        Text("Thermal Sensation")
                            .font(.headline)
                        Label("\(weatherViewModel.weatherModel.thermalSensation)", systemImage: "thermometer.sun.fill")
                    }
                    .foregroundColor(.white)
                    .symbolRenderingMode(.multicolor)
                    .padding()
                    
                    HStack(spacing: 14) {
                        VStack {
                            Label(weatherViewModel.weatherModel.max, systemImage: "thermometer.sun.fill")
                            Text("Max")
                        }
                        VStack {
                            Label(weatherViewModel.weatherModel.min, systemImage: "thermometer.snowflake")
                            Text("Min")
                        }
                    }
                    .symbolRenderingMode(.multicolor)
                    .foregroundColor(.white)
                    
                    Divider()
                        .foregroundColor(.white)
                        .padding()
                    
                    HStack(spacing: 32) {
                        VStack {
                            Image(systemName: "sunrise.fill")
                                .symbolRenderingMode(.multicolor)
                            Text(weatherViewModel.weatherModel.sunrise, style: .time)
                        }
                        
                        VStack {
                            Image(systemName: "sunset.fill")
                                .symbolRenderingMode(.multicolor)
                            Text(weatherViewModel.weatherModel.sunset, style: .time)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, 32)
            }
            .navigationTitle("The Weather")
            .background(LinearGradient(colors: [.green, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
        }
        .searchable(text: $city, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search the weather of your favorite city"))
        .textInputAutocapitalization(.never)
        .onSubmit(of: .search) {
            Task {
                await weatherViewModel.getWeatherInfo(city: city)
                print("City: \(city)")
            }
        }
    }
}

struct CityWeatherDetails_Previews: PreviewProvider {
    static var previews: some View {
        CityWeatherDetails()
    }
}
