//
//  WeatherCategory.swift
//  weatherwidgetExtension
//
//  Created by Ben Leung on 2022/05/15.
//

import Foundation

enum WeatherCategory {
    case snow
    case rain
    case suncloud
    case cloud
    case sunny
    
    /// correspond to the image name in Assets
    func iconName() -> String {
        switch self {
        
        case .snow:
            return "Snow"
        case .rain:
            return "Rain"
        case .suncloud:
            return "SunCloud"
        case .cloud:
            return "Cloud"
        case .sunny:
            return "Sunny"
        }
    }
}
