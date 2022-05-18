//
//  URL.extension.swift
//  weather
//
//  Created by Ben Leung on 2022/05/18.
//

import UIKit

extension URL {
    func saveImage(_ image: UIImage?) {
        if let image = image {
            if let data = image.jpegData(compressionQuality: 1.0) {
                try? data.write(to: self)
            }
        } else {
            try? FileManager.default.removeItem(at: self)
        }
    }
}
