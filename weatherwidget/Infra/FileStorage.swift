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

    // MARK: internal functions
    func getContainerUrl() -> URL {
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup)!
    }

    func getFileUrl(filename: Filename) -> URL {
        return getContainerUrl().appendingPathComponent(filename.rawValue)
    }
    
    func getUIImage(of filename: Filename) -> UIImage? {
        
        // need to match with file name in main app
        let imageURL = getFileUrl(filename: filename)

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
}
