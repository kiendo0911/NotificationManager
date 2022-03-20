//
//  UILabel+.swift
//  NotificationManager
//
//  Created by SGD on 18/03/2022.
//

import Foundation
import UIKit

extension UILabel {
    
    func setupNotificationMessageText(_ mess: NotificationMessageObj? ) {
        //Setup textAttributes font with hightlights
        guard let text = mess?.text, let hightLights = mess?.hightlights, !hightLights.isEmpty else { return self.text = text }
        let attribute = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .bold)]
        let attributedStr = NSMutableAttributedString(string: text)
        for element in hightLights {
            attributedStr.addAttributes(attribute, range: element)
        }
        self.attributedText = attributedStr
    }
}
