//
//  MainView.swift
//  TheWeather
//
//  Created by Iván Sánchez Torres on 27/03/23.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            CityWeatherDetails()
                .tabItem {
                    Label("City", systemImage: "building.2.fill")
                }
            
            CoordinatesWeatherDetails()
                .tabItem {
                    Label("Coordinates", systemImage: "map.fill")
                }
        }
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
