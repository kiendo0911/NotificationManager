//
//  SectionOfNotification.swift
//  NotificationManager
//
//  Created by SGD on 19/03/2022.
//

import Foundation
import RxDataSources

struct SectionOfNotification {
    var items: [NotificationObj]
}

extension SectionOfNotification: SectionModelType {
    typealias Item = NotificationObj
    
    init(original: SectionOfNotification, items: [NotificationObj]) {
        self = original
        self.items = items
    }
}
