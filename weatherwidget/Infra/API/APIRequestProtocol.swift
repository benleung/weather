//
//  APIRequestProtocol.swift
//  weatherwidgetExtension
//
//  Created by Ben Leung on 2022/05/18.
//

import Foundation

protocol APIRequestProtocol {
    var path: String { get }
}

extension APIRequestProtocol {
    func request() -> URLRequest {
        guard let url = URL(string: path) else {
            fatalError("Incorrect path for api request. path: \(path)")
        }
        return URLRequest(url: url)
    }

    func perform<T: Decodable>(decode decodable: T.Type, result: @escaping (Result<T, APIError>) -> Void) {

        URLSession.shared.dataTask(with: request()) { (data, response, error) in
            if let error = error {
                result(.failure(APIError.custom(error)))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                result(.failure(APIError.badResponse(nil)) )
                return
            }

            guard (200...299).contains(response.statusCode) else {
                result(.failure(APIError.badResponse(response.statusCode)) )
                return
            }

            guard let data = data else {
                result(.failure(APIError.noData) )
                return
            }

            do {
                let object = try JSONDecoder().decode(decodable, from: data)
                result(.success(object))
            } catch {
                result(.failure(APIError.custom(error)))
            }

        }.resume()

    }
}

