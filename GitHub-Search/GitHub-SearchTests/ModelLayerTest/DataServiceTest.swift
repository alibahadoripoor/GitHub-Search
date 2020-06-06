//
//  DataServiceTest.swift
//  GitHub-SearchTests
//
//  Created by Ali Bahadori on 06.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import XCTest
@testable import GitHub_Search

class DataServiceTest: XCTestCase {

    func testDataServiceConnection() {
        let expectation = self.expectation(description: "Data Service Connection is OK")
        let url = URL(string: "https://api.github.com/")!
        
        DataService.fetchData(for: url) { (data, err) in
            if data != nil{
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 8, handler: nil)
    }
}
