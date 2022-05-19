//
//  weatherwidget.swift
//  weatherwidget
//
//  Created by Ben Leung on 2022/05/14.
//

import WidgetKit
import SwiftUI
import infra

struct Provider: TimelineProvider {
    /// Data for immediate after installation
    func placeholder(in context: Context) -> Entry {
        return Entry(weather: nil, location: nil)
    }

    /// Mock Data for Widget Gallery
    func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
        let weather = WeatherCategory.sunny
        let location = LocationDTO(cityName: "San Francisco, CA", countryCode: "USA")
        let entry = Entry(weather: weather, location: location)

        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        LocationManager.shared.fetchLatestGpsLocation()

        guard let coordinate = LocationManager.shared.gpsLocation else {
            getPlaceholderTimeLine(in: context, completion: completion)
            return
        }

        CurrentWeatherRepository.fetchWeatherEntryFrom(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        ) { entry in
            let currentDate = Date()
            let nextMinute = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!

            var entries = [Entry]()
            if let entry = entry {
                // do not update widget's content (keep it as it is) when there is error
                entries.append(entry)
            }
            let timeline = Timeline(entries: entries, policy: .after(nextMinute))
            completion(timeline)
        }
    }
    
    private func getPlaceholderTimeLine(in context: Context, completion: @escaping ((Timeline<Entry>) -> ())) {
        let currentDate = Date()
        let nextMinute = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
        
        let timeline = Timeline(entries: [placeholder(in: context)], policy: .after(nextMinute))
        completion(timeline)
    }
}

struct Entry: TimelineEntry {
    var date: Date

    var weather: WeatherCategory?
    var location: LocationDTO?
    var backgroundImage: UIImage?

    init(weather: WeatherCategory?, location: LocationDTO?, backgroundImage: UIImage? = nil) {
        date = Date()
        self.weather = weather
        self.location = location
        self.backgroundImage = backgroundImage
    }

    init(currentWeatherResponse: CurrentWeatherResponse) {
        date = Date()

        let weather = currentWeatherResponse.getWeatherCategory()
        let location = LocationDTO(
            cityName: currentWeatherResponse.getCityName(),
            countryCode: currentWeatherResponse.getCountryCode()
        )

        self.weather = weather
        self.location = location
        self.backgroundImage = BackgroundImageRepository.getBackgroundImage()
    }
}

@main
struct WeatherWidget: Widget {
    let kind: String = "weatherwidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WeatherWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Weather Widget")
        .description("This is a weather widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct weatherwidget_Previews: PreviewProvider {
    static var previews: some View {
        // Small Widget
        WeatherWidgetEntryView(entry: Entry(weather: .sunny, location: LocationDTO(cityName: "San Francisco, CA", countryCode: "USA")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        
        WeatherWidgetEntryView(entry: Entry(weather: .suncloud, location: LocationDTO(cityName: "San Francisco, CA", countryCode: "USA")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        
        WeatherWidgetEntryView(entry: Entry(weather: .cloud, location: LocationDTO(cityName: "San Francisco, CA", countryCode: "USA")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))

        
        // Medium Widget
        WeatherWidgetEntryView(entry: Entry(weather: .rain, location: LocationDTO(cityName: "San Francisco, CA", countryCode: "USA")))
            .previewContext(WidgetPreviewContext(family: .systemMedium))

        // Large Widget
        WeatherWidgetEntryView(entry: Entry(weather: .snow, location: LocationDTO(cityName: "San Francisco, CA", countryCode: "USA")))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
        
        // Edge case: if only location data not found
        WeatherWidgetEntryView(entry: Entry(weather: .sunny, location: nil))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        
        // Edge case: if weather data not found
        WeatherWidgetEntryView(entry: Entry(weather: nil, location: nil))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
