//
//  weatherwidget.swift
//  weatherwidget
//
//  Created by Ben Leung on 2022/05/14.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    var locationManager: LocationManager

    init() {
        locationManager = LocationManager()
        locationManager.update()
    }
    
    func placeholder(in context: Context) -> Entry {
        // TODO: when data is not available yet after download
//        let weather = WeatherCategory.sunny
//        let location = LocationDTO.init(cityName: <#T##String#>, countryCode: <#T##String#>)
        return Entry(weather: nil, location: nil)
    }

    // Mock Data for Widget Gallery
    func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
        let weather = WeatherCategory.sunny
        let location = LocationDTO(cityName: "San Francisco, CA", countryCode: "USA")
        let entry = Entry(weather: weather, location: location)
        
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let nextMinute = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
        
        locationManager.update()
        let coordinate = locationManager.gpsLocation

        let appId = "17b7ea249a97ab2cbc7a2f4e01d4ff8e" // TODO: refactor this into a seperate layer
        
        let lat = coordinate?.latitude ?? 34  // dun use tentative data
        let lon = coordinate?.longitude ?? 139
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(appId)")!
        let request = URLRequest(url: url)
        URLSession.perform(request, decode: CurrentWeatherResponse.self) { (result) in
            switch result {
            case .failure(let error):
                // FIXME: error handling
                let entries: [Entry] = []
                let timeline = Timeline(entries: entries, policy: .after(nextMinute))
                completion(timeline)
            case .success(let object):
                let entries: [Entry] = [convertApiResponseToEntry(currentWeatherResponse: object)]
                
                let timeline = Timeline(entries: entries, policy: .after(nextMinute))
                completion(timeline)
            }
        }
    }
    
    private func convertApiResponseToEntry(
        currentWeatherResponse: CurrentWeatherResponse
    ) -> Entry {
        let weather = currentWeatherResponse.weather.first?.toWeatherCategory()
        let location = LocationDTO(cityName: currentWeatherResponse.getCityName(), countryCode: currentWeatherResponse.getCountryCode()) // FIXME: debuging
        let entry = Entry(weather: weather, location: location)

        return entry
    }
}

struct Entry: TimelineEntry {
    var date: Date
    
    var weather: WeatherCategory?
    var location: LocationDTO?
    // backgroundImage
    // textColor
    
    init(weather: WeatherCategory?, location: LocationDTO?) {
        date = Date()
        self.weather = weather
        self.location = location
    }
}

struct weatherwidgetEntryView : View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var family: WidgetFamily
    
    var body: some View {
        switch family {
        case .systemSmall:
            SmallWeatherWidget(
                iconName: entry.weather?.iconName(),
                locationDisplayName: entry.location?.displayName()
            )
            // FIXME: backgroud
        case .systemMedium:
            // FIXME: backgroud
            MediumWeatherWidget(
                iconName: entry.weather?.iconName(),
                locationDisplayName: entry.location?.displayName()
            )
        case .systemLarge:
            LargeWeatherWidget(
                iconName: entry.weather?.iconName(),
                locationDisplayName: entry.location?.displayName()
            )
            // FIXME: backgroud
        @unknown default:
            // Not expected to be called
            EmptyView()
        }
    }
    
}

@main
struct WeatherWidget: Widget {
    let kind: String = "weatherwidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            weatherwidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Weather Widget")
        .description("This is a weather widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct weatherwidget_Previews: PreviewProvider {
    static var previews: some View {
        weatherwidgetEntryView(entry: Entry(weather: .sunny, location: LocationDTO(cityName: "San Francisco, CA", countryCode: "USA")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        
        weatherwidgetEntryView(entry: Entry(weather: .sunny, location: LocationDTO(cityName: "San Francisco, CA", countryCode: "USA")))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        
        weatherwidgetEntryView(entry: Entry(weather: .sunny, location: LocationDTO(cityName: "San Francisco, CA", countryCode: "USA")))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
