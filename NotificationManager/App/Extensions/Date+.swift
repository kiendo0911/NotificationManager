//
//  Date+.swift
//  NotificationManager
//
//  Created by SGD on 18/03/2022.
//

import Foundation

extension Date {
    func convertToStr() -> String {
        //Convert date to Str format dd/MM/yy, HH:mm
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yy, HH:mm"
        return dateFormat.string(from: self)
    }
}
