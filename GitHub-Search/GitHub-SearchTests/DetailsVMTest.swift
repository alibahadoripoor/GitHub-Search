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
        let viewModel = DetailsVM()
        
        viewModel.loadRepositoriesForks(for: "nextcloud", repoName: "ios", page: 1)
        
        viewModel.fetchedCells.bind { (cells) in
            if let cells = cells, cells.count > 0{
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 8, handler: nil)
    }
    
    func testLastPageOfRepositoriesForksLoaded() {
        let expectation = self.expectation(description: "Last Page of Repositories Forks is Loaded")
        let viewModel = DetailsVM()
        
        viewModel.loadRepositoriesForks(for: "nextcloud", repoName: "ios", page: 14)
        
        viewModel.isLastPage.bind { (isLastPage) in
            if let isLastPage = isLastPage, isLastPage {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 8, handler: nil)
    }
    
}
