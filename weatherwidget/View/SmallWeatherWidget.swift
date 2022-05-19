//
//  SmallWeatherWidget.swift
//  weatherwidgetExtension
//
//  Created by Ben Leung on 2022/05/15.
//

import Foundation
import SwiftUI

struct SmallWeatherWidget: View {
    let iconName: String
    let locationDisplayName: String?
    let backgroundImage: UIImage?

    init(iconName: String, locationDisplayName: String?, backgroundImage: UIImage?) {
        self.iconName = iconName
        self.locationDisplayName = locationDisplayName
        self.backgroundImage = backgroundImage
    }
    
    var body: some View {
        ZStack {
            
            if let backgroundImage = backgroundImage {
                Image(uiImage: backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .clipped()
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(0.3)
            }
            
            VStack {
                Image(iconName)
                    .resizable()
                    .frame(width: 67.0, height: 67.0)
                
                Text(locationDisplayName ?? "-")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 18))
                    .foregroundColor(backgroundImage != nil ? .white : .black)
            }
        }
    }
}
