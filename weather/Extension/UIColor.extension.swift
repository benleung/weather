//
//  UIColor.extension.swift
//  weather
//
//  Created by Ben Leung on 2022/05/15.
//

import UIKit

extension UIColor {
    public convenience init(hex: String, alpha: CGFloat = 1.0) {
        let value = Int("000000" + hex, radix: 16) ?? 0
        let red = CGFloat(value / Int(powf(256, 2)) % 256) / 255
        let green = CGFloat(value / Int(powf(256, 1)) % 256) / 255
        let blue = CGFloat(value / Int(powf(256, 0)) % 256) / 255
        self.init(red: red, green: green, blue: blue, alpha: min(max(alpha, 0), 1))
    }
}
