//
//  CurrentWeatherRepository.swift
//  weatherwidgetExtension
//
//  Created by Ben Leung on 2022/05/19.
//

import Foundation

class CurrentWeatherRepository {
    
    static func fetchWeatherEntryFrom(latitude: Double, longitude: Double, completion: @escaping (Entry?) -> ()) {
        let request = WeatherRequest(
            latitude: latitude,
            longitude: longitude
        )
        request.perform(decode: CurrentWeatherResponse.self) { (result) in
            switch result {
            case .success(let object):
                completion(Entry(currentWeatherResponse: object))
            case .failure:
                completion(nil)
            }
        }
    }
}
