//
//  URLSession.extension.swift
//  weatherwidgetExtension
//
//  Created by Ben Leung on 2022/05/15.
//

import Foundation

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


//URLSession.shared.dataTask(with: url) { data, response, error in
//    if let error = error {
//        // TODO: error handling
//        // FIXME: use previous entry
//        return
//    }

//    do {
//        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
//
//
//        let timeline = Timeline(entries: entries, policy: .after(nextMinute))
//
//        completion(timeline)
//    } catch {
//        print("invalid format")
//    }
//
//
//}
