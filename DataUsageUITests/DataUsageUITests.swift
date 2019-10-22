//
//  DataUsageUITests.swift
//  DataUsageUITests
//
//  Created by Suri,Sai Sailesh Kumar on 20/10/19.
//  Copyright © 2019 Sailesh. All rights reserved.
//

import XCTest

class DataUsageUITests: XCTestCase {
    
    var app: XCUIApplication!


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    /// To Test weather the year data is displayed
    func testYear2018DataTableDisplayed() {
        let table = app.tables
        XCTAssertTrue(table.staticTexts["2018"].exists, "validating data displayed over cell")
        XCTAssert(table.cells.count != 0, "checking for the data displayed")
    }
    
    func testTapOnDecreaseButtonOverTable() {
        let table = app.tables
        let cell = table.cells.element(boundBy: 3)
        let button = cell.buttons["decrease"]
        button.tap()
        sleep(5)
        XCTAssert(app.otherElements["popover"].exists, "checks if popover is presented")
    }
    

}

