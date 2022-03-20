//
//  NotificationManagerUITests.swift
//  NotificationManagerUITests
//
//  Created by SGD on 18/03/2022.
//

import XCTest

class NotificationManagerUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNotificationReading() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        let tableCell = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Lê Thị Trúc 25 đã đăng một bài viết mới: DỰ ĐOÁN VIỆT NAM..."]/*[[".cells.staticTexts[\"Lê Thị Trúc 25 đã đăng một bài viết mới: DỰ ĐOÁN VIỆT NAM...\"]",".staticTexts[\"Lê Thị Trúc 25 đã đăng một bài viết mới: DỰ ĐOÁN VIỆT NAM...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(tableCell.exists)
        tableCell.tap()
    }
    
    func testSearchUI() throws {
        let app = XCUIApplication()
        let btnSearch = app.buttons["ic search"]
        XCTAssertTrue(btnSearch.exists)
        btnSearch.tap()
        
        let searchField = app.searchFields["Tìm kiếm"]
        XCTAssertTrue(searchField.exists)
        searchField.tap()
        searchField.typeText("Tin")
        
        let btnClear = searchField.buttons["Clear text"]
        XCTAssertTrue(btnClear.exists)
        btnClear.tap()
        
        let btnClose = app.buttons["ic close"]
        XCTAssertTrue(btnClose.exists)
        btnClose.tap()
    }
}
