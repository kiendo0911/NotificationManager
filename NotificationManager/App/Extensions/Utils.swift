//
//  Utils.swift
//  NotificationManager
//
//  Created by SGD on 19/03/2022.
//

import Foundation
import SwiftyJSON

class Utils {
    static let shared = Utils()
    var test = false
    
    func convertJsonToNotifications(_ json: JSON) -> [NotificationObj] {
        return json["data"].arrayValue.map({NotificationObj($0.dictionaryObject)})
    }
    
    func sortListNotifiWithDate(_ items: [NotificationObj]?) -> [NotificationObj]? {
        guard let items = items else {
            return nil
        }

        return items.sorted {noti1, noti2 in
            let dateNoti1 = noti1.createdAt ?? Date()
            let dateNoti2 = noti2.createdAt ?? Date()
            return dateNoti1 > dateNoti2
        }
    }
    
    func filterNotificationsWithString(_ str: String?, items: [NotificationObj]?) -> [NotificationObj]? {
        guard let items = items else { return nil }
        guard let str = str, !str.isEmpty else {return items}
        let strSearch = str.folding(options: .diacriticInsensitive, locale: .current).lowercased()
        return items.filter{ $0.message?.text?.lowercased().folding(options: .diacriticInsensitive, locale: .current).contains(strSearch) ?? false }
    }
}
