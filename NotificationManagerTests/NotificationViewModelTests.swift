//
//  NotificationViewModelTests.swift
//  NotificationManagerTests
//
//  Created by SGD on 20/03/2022.
//

import XCTest
@testable import NotificationManager

class NotificationViewModelTests: XCTestCase {
    
    var notificationSuccess: [NotificationObj]?
    var notificationFail: [NotificationObj]?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        let json = try? ReadFileJson.shared.fetchFileJson()
        if json != nil {
            self.notificationSuccess = Utils.shared.convertJsonToNotifications(json!)
        }
        
        let jsonFailed = try? ReadFileJson.shared.fetchFileJson("json")
        if jsonFailed != nil {
            self.notificationSuccess = Utils.shared.convertJsonToNotifications(jsonFailed!)
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        notificationSuccess = nil
        notificationFail = nil
        try super.tearDownWithError()
    }
    
    func testGetNotificationsSuccess() throws {
        XCTAssertEqual(notificationSuccess?.count, 30)
    }
    
    func testGetNotificationsFailed() throws {
        XCTAssertNil(notificationFail)
    }
    
    func testReadNotification() throws {
        XCTAssertNotNil(self.notificationSuccess?.first)
        let notifi = self.notificationSuccess?.filter{ $0.status == false }.first
        XCTAssertNotNil(notifi?.status)
        XCTAssertFalse(notifi!.status!)
        notifi!.status = true
        let notifiUpdate = self.notificationSuccess?.filter{$0.id == notifi?.id}.first
        XCTAssertNotNil(notifiUpdate?.status)
        XCTAssertTrue(notifiUpdate!.status!)
    }
    
    func testPerformanceFilterListNotification() throws {
        self.measure {
            let _ = Utils.shared.filterNotificationsWithString("Tin", items: self.notificationSuccess)
        }
    }
    
    func testPerformanceSortedListNotification() throws {
        self.measure {
            let _ = Utils.shared.sortListNotifiWithDate(self.notificationSuccess)
        }
    }

    func testPerformanceGetNotifications() throws {
        self.measure {
            let json = try? ReadFileJson.shared.fetchFileJson()
            guard json != nil else {return}
            let listNotifi = Utils.shared.convertJsonToNotifications(json!)
            let listSorted = Utils.shared.sortListNotifiWithDate(listNotifi)
            let _ = Utils.shared.filterNotificationsWithString(nil, items: listSorted)
        }
    }
}
