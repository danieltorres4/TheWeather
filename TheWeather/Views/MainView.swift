//
//  MainView.swift
//  TheWeather
//
//  Created by Iván Sánchez Torres on 27/03/23.
//

import SwiftUI

struct MainView: View {
    @StateObject private var weatherViewModel = WeatherViewModel()
    @State var cityToSearch = ""
    
    var body: some View {
        ZStack {
            
            VStack {
                Text(weatherViewModel.weatherModel.city)
                    .foregroundColor(.white)
                    .font(.system(size: 70))
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
                            .font(.system(size: 70))
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
        .background(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
        .task {
            await weatherViewModel.getWeatherInfo(city: "dortmund")
        }
        //.searchable(text: $cityToSearch)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
