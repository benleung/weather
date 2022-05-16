//
//  CurrentWeatherResponse.swift
//  weatherwidgetExtension
//
//  Created by Ben Leung on 2022/05/15.
//

import Foundation

// Details: API Response of JSON https://openweathermap.org/current
struct CurrentWeatherResponse: Decodable {
    var name: String  // city name
    var weather: [Weather]
    var sys: Sys
    
    struct Sys: Decodable {
        var country: String
    }
    
    func getCityName() -> String {
        return name
    }
    
    func getCountryCode() -> String {
        return sys.country
    }
}
