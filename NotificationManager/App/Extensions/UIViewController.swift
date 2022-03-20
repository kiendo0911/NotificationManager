//
//  UIViewController.swift
//  NotificationManager
//
//  Created by SGD on 19/03/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showToast(_ str: String) {
        //Show toast if Error
        ToastManager.shared.showToast(self, str: str)
    }
}
