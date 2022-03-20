//
//  NotificationObjTests.swift
//  NotificationManagerTests
//
//  Created by SGD on 19/03/2022.
//

import XCTest
@testable import NotificationManager
class NotificationObjTests: XCTestCase {
    var notificationObj: NotificationObj?
    var notificationFailedMessage: NotificationObj?
    let dictionaryNotifiSuccess: [String: Any] = [
        "id": "60c2d917dfab450023476145",
        "message": [
            "text" : "Tin nội bộ G đã đăng một bài viết mới trong nhóm Sào huyệt G-Group: Anh chị em G-er ơi,...",
            "highlights": [
                ["offset": 0, "length": 12], ["offset": 49, "length": 17]
            ]
        ],
        "image": "https://image-1.gapowork.vn/images/16ad0a91-6af4-4571-ad43-91540fa633a2.jpeg",
        "icon": "https://image-1.gapo.vn/images/icon/new/group2.png",
        "status": "unread",
        "createdAt": 1623382295,
    ]
    
    let dictionaryNotifiFailedMessage: [String: Any] = [
        "id": "60c2d917dfab450023476145",
        "image": "https://image-1.gapowork.vn/images/16ad0a91-6af4-4571-ad43-91540fa633a2.jpeg",
        "icon": "https://image-1.gapo.vn/images/icon/new/group2.png",
        "status": "unread",
        "createdAt": 1623382295,
    ]

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        self.notificationObj = NotificationObj(dictionaryNotifiSuccess)
        self.notificationFailedMessage = NotificationObj(dictionaryNotifiFailedMessage)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        notificationObj = nil
        try super.tearDownWithError()
    }
    
    func testJsonConvertToNotificationSuccess() throws {
        XCTAssertNotNil(self.notificationObj)
        let notifi = self.notificationObj!
        XCTAssertNotNil(notifi.id)
        XCTAssertNotNil(notifi.icon)
        XCTAssertNotNil(notifi.image)
        XCTAssertNotNil(notifi.status)
        XCTAssertNotNil(notifi.createdAt)
        XCTAssertNotNil(notifi.message?.text)
        XCTAssertNotNil(notifi.message?.hightlights)
    }
    
    func testJsonConvertToNotificationFailedMessage() throws {
        XCTAssertNotNil(self.notificationFailedMessage)
        let notifi = self.notificationFailedMessage!
        XCTAssertNotNil(notifi.id)
        XCTAssertNotNil(notifi.icon)
        XCTAssertNotNil(notifi.image)
        XCTAssertNotNil(notifi.status)
        XCTAssertNotNil(notifi.createdAt)
        XCTAssertNil(notifi.message)
    }

    func testPerformanceDictionaryConvertToNotification() throws {
        self.measure {
            let _ = NotificationObj(dictionaryNotifiSuccess)
        }
    }
    
    func testPerformanceNotificationDateConvertToString() throws {
        self.measure {
            let _ = self.notificationObj?.createdAt?.convertToStr()
        }
    }

}
