//
//  LocationDTO.swift
//  weatherwidgetExtension
//
//  Created by Ben Leung on 2022/05/15.
//

import Foundation

struct LocationDTO {
    let cityName: String // e.g. Mountain View
    let countryCode: String // e.g. US

    func displayName() -> String {
        return "\(cityName), \(countryCode)"
    }
}
