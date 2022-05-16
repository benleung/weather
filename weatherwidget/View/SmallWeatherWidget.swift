//
//  SmallWeatherWidget.swift
//  weatherwidgetExtension
//
//  Created by Ben Leung on 2022/05/15.
//

import Foundation
import SwiftUI

struct SmallWeatherWidget: View {
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
                .frame(width: 67.0, height: 67.0)
            
            Text(locationDisplayName ?? "-")
                .multilineTextAlignment(.leading)
                .font(.system(size: 18))
        }
    }
}
