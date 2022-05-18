//
//  WidgetVCProtocol.swift
//  weather
//
//  Created by Ben Leung on 2022/05/18.
//

import UIKit

protocol WidgetVCProtocol {
    var backgroundImage: UIImageView! { get }
    var overlayView: UIView! { get }
    var locationNameLabel: UILabel! { get }
    
    func updateBackground(image: UIImage?)
}

extension WidgetVCProtocol {
    func updateBackground(image: UIImage? = nil) {
        let isHasBackground: Bool
        if let image = image {
            backgroundImage.image = image
            isHasBackground = true
        } else {
            isHasBackground = false
        }
        backgroundImage.isHidden = !isHasBackground
        overlayView.isHidden = !isHasBackground
        locationNameLabel.textColor = isHasBackground ? .white : .black
    }
}
