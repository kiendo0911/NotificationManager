//
//  NotificationObj.swift
//  NotificationManager
//
//  Created by SGD on 18/03/2022.
//


import Foundation
import SwiftyJSON
import RxDataSources

struct NotificationMessageObj {
    var hightlights: [NSRange]?
    var text: String?
    
    init(_ dictionary: [String: Any?]?) {
        // Setup object notification message with list dictionary
        guard let dictionary = dictionary else {
            return
        }
        self.text = dictionary["text"] as? String
        if let dictionaryHightlights = dictionary["highlights"] as? [[String: Int]] {
            var listHightLight = [NSRange]()
            for element in dictionaryHightlights {
                if let offset = element["offset"], let length = element["length"] {
                    listHightLight.append(NSRange(location: offset, length: length))
                }
            }
            self.hightlights = listHightLight.isEmpty ? nil : listHightLight
        }
    }
}

class NotificationObj {
    var id:String?
    var message: NotificationMessageObj?
    var image: String?
    var icon: String?
    var status: Bool?
    var createdAt: Date?
    
    init(_ dictionary: [String: Any?]?) {
        // Setup object notification with list dictionary
        guard let dictionary = dictionary else {
            return
        }
        self.id = dictionary["id"] as? String
        self.icon = dictionary["icon"] as? String
        self.image = dictionary["image"] as? String
        self.status = self.getStatus(dictionary["status"] as? String)
        self.createdAt = self.getCreateAt(dictionary["createdAt"] as? Int)
        if let messageDictionary = dictionary["message"] as? [String:AnyObject] {
            self.message = NotificationMessageObj(messageDictionary)
        }
    }
}

extension NotificationObj {
    private func getStatus(_ status: String?) -> Bool? {
        // Convert status notification
        guard let status = status else {
            return nil
        }
        
        if status == "unread" {
            return false
        } else if status == "read" {
            return true
        } else {
            return nil
        }
    }
    
    private func getCreateAt(_ date: Int?) -> Date? {
        // Convert date
        guard let date = date else {
            return nil
        }
        return Date(timeIntervalSince1970: Double(date))
    }
}



