//
//  weatherwidget.swift
//  weatherwidget
//
//  Created by Ben Leung on 2022/05/14.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
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

        let appId = "17b7ea249a97ab2cbc7a2f4e01d4ff8e"
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=\(appId)")!
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
        let location = LocationDTO(cityName: currentWeatherResponse.getCityName(), countryCode: currentWeatherResponse.getCountryCode())
        let entry = Entry(weather: weather, location: location)

        return entry
    }
}



// Entity Layer
struct Weather: Decodable {
    let id: Int
    
    /// id correspond to definition in weather.id
    /// details: https://openweathermap.org/weather-conditions}
    init(id: Int) {
        self.id = id
    }
    
    // TODO: Write Test
    func toWeatherCategory() -> WeatherCategory? {
        switch id {
        case 200...299:
            return .cloud // Group 2xx: Thunderstorm
        case 300...399:
            return .cloud // Group 3xx: Drizzle
        case 500...599:
            return .rain // Group 5xx: Rain
        case 600...699:
            return .snow // Group 6xx: Snow
        case 700...799:
            return .cloud // Group 7xx: Atmosphere
        case 800:
            return .sunny // Group 800: Clear
        case 801:
            return .suncloud // Group 80x: Clouds (scattered clouds: 11-25%)
        case 802...804:
            return .cloud // Group 80x: Clouds (scattered clouds: 25-100%)
        default:
            return nil  // If unrecognized id is found in api response, return nil
        }
    }
}

// Details: API Response of JSON https://openweathermap.org/current
struct CurrentWeatherResponse: Decodable {
    var name: String  // city name
    var weather: [Weather]
    var sys: Sys
    
    struct Sys: Decodable {
        var country: String
    }
    
    func getCityName() -> String {
        return name
    }
    
    func getCountryCode() -> String {
        return sys.country
    }
}



// Application Layer
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


struct LocationDTO {
    let cityName: String // e.g. Mountain View
    let countryCode: String // e.g. US

    func displayName() -> String {
        return "\(cityName), \(countryCode)"
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
            VStack {
                Image(entry.weather?.iconName() ?? "Sunny") // TODO: placeholder for sunny
                    .resizable()
                    .frame(width: 67.0, height: 67.0)
                
                Text(entry.location?.displayName() ?? "-")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 18))
            }
            // FIXME: backgroud
        case .systemMedium:
            VStack {
                Image(entry.weather?.iconName() ?? "Sunny") // TODO: placeholder for sunny
                    .resizable()
                    .frame(width: 82.0, height: 82.0)
                
                Text(entry.location?.displayName() ?? "-")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 24))
            }
            // FIXME: backgroud
        case .systemLarge:
            VStack {
                Image(entry.weather?.iconName() ?? "Sunny") // TODO: placeholder for sunny
                    .resizable()
                    .frame(width: 155.0, height: 155.0)
                
                Text(entry.location?.displayName() ?? "-")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 32))
            }
            // FIXME: backgroud
        @unknown default:
            // Not expected to be called
            EmptyView()
        }
    }
    
}

@main
struct weatherwidget: Widget {
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
