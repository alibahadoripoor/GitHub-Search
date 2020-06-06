//
//  DetailsVMTest.swift
//  GitHub-SearchTests
//
//  Created by Ali Bahadori on 02.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import XCTest
@testable import GitHub_Search

class DetailsVMTest: XCTestCase {
    
    func testLoadRepositoriesForks() {
        let expectation = self.expectation(description: "Load Repository Forks")
        let viewModel = DetailsVM(service: MockService())
        
        viewModel.loadRepositoriesForks(for: "", repoName: "", page: 1)
        
        viewModel.fetchedCells.bind { (cells) in
            if let cells = cells, cells.count > 0{
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
 
}
