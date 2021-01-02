//
//  UIColorExtension.swift
//  Alias
//
//  Created by Josip Peric on 22/12/2020.
//

import Foundation
import UIKit

extension UIColor {
    static func randomColor() -> UIColor
    {
        return UIColor(red: CGFloat(arc4random() % 255) / 255.0, green: CGFloat(arc4random() % 255) / 255.0, blue: CGFloat(arc4random() % 255) / 255.0, alpha: 1.0)
    }
}
