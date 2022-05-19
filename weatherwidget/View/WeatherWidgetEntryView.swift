//
//  WeatherWidgetEntryView.swift
//  weatherwidgetExtension
//
//  Created by Ben Leung on 2022/05/19.
//

import WidgetKit
import SwiftUI

struct WeatherWidgetEntryView : View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var family: WidgetFamily
    
    var body: some View {
        if let weatherIconName = entry.weather?.iconName() {
            switch family {
            case .systemSmall:
                SmallWeatherWidget(
                    iconName: weatherIconName,
                    locationDisplayName: entry.location?.displayName(),
                    backgroundImage: entry.backgroundImage
                )
            case .systemMedium:
                MediumWeatherWidget(
                    iconName: weatherIconName,
                    locationDisplayName: entry.location?.displayName(),
                    backgroundImage: entry.backgroundImage
                    
                )
            case .systemLarge:
                LargeWeatherWidget(
                    iconName: weatherIconName,
                    locationDisplayName: entry.location?.displayName(),
                    backgroundImage: entry.backgroundImage
                )
            case .systemExtraLarge:
                // Not expected to be called
                EmptyView()
            @unknown default:
                // Not expected to be called
                EmptyView()
            }
        } else {
            ErrorWidgetView()
        }
    }
    
}
