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
    
    func updateBackground(url: String?)
}

extension WidgetVCProtocol {
    func updateBackground(url: String? = nil) {
        let isHasBackground: Bool
        if let url = url {
            do {
                let nsurl = URL(fileURLWithPath: url)
                let imageData = try Data(contentsOf: nsurl)
                backgroundImage.image = UIImage(data: imageData as Data)
                
                isHasBackground = true
            } catch {
                print("Error loading image : \(error)")

                isHasBackground = false
            }
        } else {
            isHasBackground = false
        }
        backgroundImage.isHidden = !isHasBackground
        overlayView.isHidden = !isHasBackground
        locationNameLabel.textColor = isHasBackground ? .white : .black
    }
}
