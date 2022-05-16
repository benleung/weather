//
//  Weather.swift
//  weatherwidgetExtension
//
//  Created by Ben Leung on 2022/05/15.
//

import Foundation

struct Weather: Decodable {
    let id: Int
    
    /// id correspond to definition in weather.id
    /// details: https://openweathermap.org/weather-conditions}
    init(id: Int) {
        self.id = id
    }
    
    // TODO: Write Test
    func toWeatherCategory() -> WeatherCategory? {
        switch id {
        case 200...299:
            return .cloud // Group 2xx: Thunderstorm
        case 300...399:
            return .cloud // Group 3xx: Drizzle
        case 500...599:
            return .rain // Group 5xx: Rain
        case 600...699:
            return .snow // Group 6xx: Snow
        case 700...799:
            return .cloud // Group 7xx: Atmosphere
        case 800:
            return .sunny // Group 800: Clear
        case 801:
            return .suncloud // Group 80x: Clouds (scattered clouds: 11-25%)
        case 802...804:
            return .cloud // Group 80x: Clouds (scattered clouds: 25-100%)
        default:
            return nil  // If unrecognized id is found in api response, return nil
        }
    }
}
