//
//  SceneDelegate.swift
//  weather
//
//  Created by Ben Leung on 2022/05/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let appId = "17b7ea249a97ab2cbc7a2f4e01d4ff8e"
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=\(appId)")!
        let request = URLRequest(url: url)
        URLSession.perform(request, decode: CurrentWeatherResponse.self) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let object):
                print(object.name)
            }
        }
        
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


// FIXME: debug
struct CurrentWeatherResponse: Decodable {
    var name: String  // city name
    var weather: [Weather]  // why this is an array
    var sys: Sys
    
    struct Sys: Decodable {
        var country: String
    }
}

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
            return nil  // If unrecognized id is found in api response
        }
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

extension URLSession {

    static func perform<T: Decodable>(_ request: URLRequest, decode decodable: T.Type, result: @escaping (Result<T, Error>) -> Void) {

        URLSession.shared.dataTask(with: request) { (data, response, error) in

            // handle error scenarios... `result(.failure(error))`
            // handle bad response... `result(.failure(responseError))`
            // handle no data... `result(.failure(dataError))`

            guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {
                return
            }
            
            do {
                let object = try JSONDecoder().decode(decodable, from: data)
                result(.success(object))
            } catch {
                result(.failure(error))
            }

        }.resume()

    }

}
