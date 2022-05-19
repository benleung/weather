//
//  LargeWeatherWidget.swift
//  weatherwidgetExtension
//
//  Created by Ben Leung on 2022/05/15.
//

import Foundation
import SwiftUI

struct LargeWeatherWidget: View {
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
                    .frame(width: 155.0, height: 155.0)

                Text(locationDisplayName ?? "-")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 32))
                    .foregroundColor(backgroundImage != nil ? .white : .black)
            }
        }
    }
}
