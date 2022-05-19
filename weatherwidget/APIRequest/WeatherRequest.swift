//
//  WeatherRequest.swift
//  weatherwidgetExtension
//
//  Created by Ben Leung on 2022/05/19.
//

import Foundation

// Details: API Request https://openweathermap.org/current
struct WeatherRequest: APIRequestProtocol {
    var longitude: Double
    var latitude: Double
    
    private var appId = "17b7ea249a97ab2cbc7a2f4e01d4ff8e"

    var path: String {
        return "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(appId)"
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
