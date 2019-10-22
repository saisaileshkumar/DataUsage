//
//  DataUsageTests.swift
//  DataUsageTests
//
//  Created by Suri,Sai Sailesh Kumar on 20/10/19.
//  Copyright © 2019 Sailesh. All rights reserved.
//

import XCTest
@testable import DataUsage

class DataUsageTests: XCTestCase {
    
    let response : [String: Any] = ["help": "https://data.gov.sg/api/3/action/help_show?name=datastore_search", "success": true, "result": ["records" : [["volume_of_mobile_data": "0.171586", "quarter": "2008-Q1", "_id": 15],["volume_of_mobile_data": "0.248899", "quarter": "2008-Q2", "_id": 16],["volume_of_mobile_data": "0.439655", "quarter": "2008-Q3", "_id": 17],["volume_of_mobile_data": "0.683579", "quarter": "2008-Q4", "_id": 18]]]]


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    
    /// tests the service response
    func testDataVolumeService() {
        let service = expectation(description: "MobileDataUsage service")
        let networkManager = DUNetworkManager()
        networkManager.getMobileDataUsageVolumes(networkManager.serviceUrl, completionHandler: { (result, error, response) in
            if let _ = result {
                service.fulfill()
                XCTAssertTrue(true, "response received successfully")
            } else {
                XCTAssertTrue(false, "error fetching response")

            }
        })
        waitForExpectations(timeout: 20) { (error) in
            if let e = error {
                XCTAssertFalse(true, e.localizedDescription)
            }
        }
    }
    
    /// test for valid status code
    func testValidStatusCodes() {
        let networkError = DUNetWorkErrors()
        let status = networkError.checkValidStatusCode(statusCode: 200)
        XCTAssertTrue(status, "queried is a valid status code")
        let statusFail = networkError.checkValidStatusCode(statusCode: 403)
        XCTAssertFalse(statusFail)
    }
    
    /// test error title for network errors
    func testErrorTitleForNetworkErrors() {
        let networkError = DUNetWorkErrors()
        let result = networkError.errorTitle(statusCode: 403)
        if result == "Forbidden" {
            XCTAssertTrue(true, "Forbidden is returned")
        } else {
            XCTAssertTrue(false, "Forbidden is not returned as error tite")
        }
        
        let resultServer = networkError.errorTitle(statusCode: 502)
        if resultServer == "Bad Gateway" {
            XCTAssertTrue(true, "Bad Gateway is returned")
        } else {
            XCTAssertTrue(false, "Bad Gateway is not returned as error tite")
        }
    }
    
    /// test error messagee for network
    func testErrorMessageForNetworkErrors() {
        let networkError = DUNetWorkErrors()
        let result = networkError.errorMessage(statusCode: 503)
        
         if result == "The request was not completed. The server is temporarily overloading or down." {
            XCTAssertTrue(true, "503 message is returned")
        } else {
            XCTAssertTrue(false, "503 message is not returned as error tite")
        }
        
        let resultClient = networkError.errorMessage(statusCode: 404)
        
        if resultClient == "The server can not find the requested page." {
            XCTAssertTrue(true, "404 message is returned")
        } else {
            XCTAssertTrue(false, "404 message is not returned as error tite")
        }
    }
    
    // validates or tests data saving into db
    func testSaveDataUsageRecords() {
        let dataManager = DUDataManager()
        if let records = response["records"] as? [[String: Any]] {
            dataManager.saveDataUsageForOfflineCaching(records) { status in
                XCTAssertTrue(status, "test for the saving operation of data usage")
            }
        }
    }
    
    // tests saved data to realm db
    func testSavedYearDetails() {
        let dataManager = DUDataManager()
        let years = dataManager.fetchOfflineCachedCycles()
        let result = years.count > 0
        XCTAssert(result, "validating the data saved by fetching the records")
    }
    
    
    /// testing total data count
    func testYearTotalDataCount() {
        let dataManager = DUDataManager()
        let years = dataManager.fetchOfflineCachedCycles()
        if let yearObj = years.first {
            let yearCell = DUYearCell()
            yearCell.year = yearObj
            let count = yearCell.getTotalDataConsumed()
            if count == 1.543719 {
                XCTAssertTrue(true, "data count matched")
            } else {
                XCTAssert(false, "total data count mismatched")
            }
            print(count)
        } else  {
            XCTAssert(false, "DB not updated")
        }
    }
    
    func testYearDataConsumptionDecreaseForAQuarter() {
        let dataManager = DUDataManager()
        let years = dataManager.fetchOfflineCachedCycles()
        if let yearObj = years.first {
            let yearCell = DUYearCell()
            yearCell.year = yearObj
            let result = yearCell.isQuartersDataDecreased()
            XCTAssertFalse(result, "data consumed not decreased")
        } else  {
            XCTAssert(false, "DB not updated")
        }
            
    }
}
