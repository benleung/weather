//
//  APIError.swift
//  weatherwidgetExtension
//
//  Created by Ben Leung on 2022/05/19.
//

import Foundation
enum APIError: Error {
    case badResponse(Int?) // response code
    case noData
    case custom(Error)
}
