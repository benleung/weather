//
//  FileStorageB.swift
//  infra
//
//  Created by Ben Leung on 2022/05/19.
//

import UIKit

public class FileStorage {
    public static var shared = FileStorage()
    private let appGroup = "group.benleung.weather"

    // management file name in one place to avoid filename collision
    public enum Filename: String {
        case backgroundImage = "background.jpg"
    }

    // MARK: public functions
    public func getUIImage(of filename: Filename) -> UIImage? {

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

    public func saveUIImage(image: UIImage, filename: Filename) {

        // need to match with file name in main app
        let imageURL = getFileUrl(filename: filename)

        if let data = image.jpegData(compressionQuality: 1.0) {
            try? data.write(to: imageURL)
        }
    }

    // MARK: private functions
    private func getContainerUrl() -> URL {
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup)!
    }
    
    private func getFileUrl(filename: Filename) -> URL {
        return getContainerUrl().appendingPathComponent(filename.rawValue)
    }
}
