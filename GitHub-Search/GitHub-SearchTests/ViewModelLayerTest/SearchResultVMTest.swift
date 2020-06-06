//
//  SearchResultVMTest.swift
//  GitHub-SearchTests
//
//  Created by Ali Bahadori on 02.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import XCTest
@testable import GitHub_Search

class SearchResultVMTest: XCTestCase {

    func testLoadRepositoriesForQuery() {
        let expectation = self.expectation(description: "Load Repositories For Query")
        let viewModel = SearchResultVM(service: MockService())
        
        viewModel.loadRepositories(for: "", page: 1)
        
        viewModel.fetchedCells.bind { (cells) in
            if cells != nil{
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoadHeaderRepositoriesForQuery() {
        let expectation = self.expectation(description: "Load Header Repositories For Query")
        let viewModel = SearchResultVM(service: MockService())

        viewModel.loadRepositories(for: "", page: 1)

        viewModel.fetchedHeader.bind { (header) in
            if header != nil{
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testLoadUserRepositories() {
        let expectation = self.expectation(description: "Load User Repositories")
        let viewModel = SearchResultVM(service: MockService())

        viewModel.loadUserRepositories(for: "", page: 1)

        viewModel.fetchedCells.bind { (cells) in
            if let cells = cells, cells.count > 0{
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testLoadHeaderUserRepositories() {
        let expectation = self.expectation(description: "Load Header User Repositories")
        let viewModel = SearchResultVM(service: MockService())

        viewModel.loadUserRepositories(for: "", page: 1)

        viewModel.fetchedHeader.bind { (header) in
            if header != nil{
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
    
}
