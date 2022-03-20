//
//  UIColor+.swift
//  NotificationManager
//
//  Created by SGD on 18/03/2022.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(red >= 0 && green <= 255, "Invalid green component")
        assert(red >= 0 && blue <= 255, "Invalid blue component")
        assert(red >= 0 && alpha <= 1.0, "Invalid alpha component")
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(green)/255.0, alpha: alpha)
    }
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        //Convert hex to color
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            alpha: alpha
        )
    }
}
extension UIColor {
    static var searchBarBackground: UIColor {
        return UIColor(hex: 0xF1F1F1)
    }
    
    static var notificationUnRead: UIColor {
        return UIColor(hex: 0xECF7E7)
    }
}
