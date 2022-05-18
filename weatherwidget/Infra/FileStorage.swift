//
//  FileStorage.swift
//  weatherwidgetExtension
//
//  Created by Ben Leung on 2022/05/18.
//

import UIKit

// TODO: Study whether possible to seperate this into a seperate module to be used by weatherwidgetExtension and weather
class FileStorage {
    static var shared = FileStorage()
    private let appGroup = "group.benleung.weather"

    // management file name in one place to avoid filename collision
    enum Filename: String {
        case backgroundImage = "background.jpg"
    }

    // MARK: background image
    func getBackgroundImage() -> UIImage? {
        // need to match with file name in main app
        let imageURL = getFileUrl(filename: .backgroundImage)

        guard FileManager.default.fileExists(atPath: imageURL.path) else {
            return nil
        }

        do {
            let imageData = try Data(contentsOf: imageURL)
            return UIImage(data: imageData)
        } catch {
            return nil
        }
    }
    
    
    // MARK: Private Functions
    private func getContainerUrl() -> URL {
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup)!
    }

    private func getFileUrl(filename: Filename) -> URL {
        return getContainerUrl().appendingPathComponent(filename.rawValue)
    }
}
