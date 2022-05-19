//
//  BackgroundImageRepository.swift
//  weatherwidgetExtension
//
//  Created by Ben Leung on 2022/05/19.
//

import UIKit
import infra

final class BackgroundImageRepository {
    // MARK: background image
    static func getBackgroundImage() -> UIImage? {
        return FileStorage.shared.getUIImage(of: .backgroundImage)
    }
}
