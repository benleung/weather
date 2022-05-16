//
//  MediumWeatherWidget.swift
//  weatherwidgetExtension
//
//  Created by Ben Leung on 2022/05/15.
//

import Foundation
import SwiftUI

struct MediumWeatherWidget: View {
    let iconName: String?
    let locationDisplayName: String?
    
    init(iconName: String?, locationDisplayName: String?) {
        self.iconName = iconName
        self.locationDisplayName = locationDisplayName
    }
    
    var body: some View {
        VStack {
            Image(iconName ?? "Sunny") // TODO: placeholder for sunny
                .resizable()
                .frame(width: 82.0, height: 82.0)
            
            Text(locationDisplayName ?? "-")
                .multilineTextAlignment(.leading)
                .font(.system(size: 24))
        }
    }
}
