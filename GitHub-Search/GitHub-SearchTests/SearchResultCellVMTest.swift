//
//  SearchResultCellVMTest.swift
//  GitHub-SearchTests
//
//  Created by Ali Bahadori on 02.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import XCTest
@testable import GitHub_Search

class SearchResultCellVMTest: XCTestCase {

    func testSearchResultCellVMWithSeveralNumberOfForks(){
        let owner = User(login: "ali bahadori", avatar_url: "... image URL")
        let repo = Repository(name: "GitHub-Search", description: "An iOS app for search github Repositories", owner: owner, forks: 10, watchers: 10)
        let searchResultCellVM = SearchResultCellVM(repo: repo)
        
        XCTAssertEqual(repo.name, searchResultCellVM.name)
        XCTAssertEqual(repo.description, searchResultCellVM.description)
        XCTAssertEqual(repo.owner.login, searchResultCellVM.owner.login)
        XCTAssertEqual(repo.owner.avatar_url, searchResultCellVM.owner.avatar_url)
        XCTAssertEqual("\(repo.forks) Forks   \(repo.watchers) Watchers", searchResultCellVM.forksWathersText)
        XCTAssertEqual(1, searchResultCellVM.detailsButtonAlpha)
    }

    func testSearchResultCellVMWithoutAnyForks(){
        let owner = User(login: "ali bahadori", avatar_url: "... image URL")
        let repo = Repository(name: "GitHub-Search", description: "An iOS app for search github Repositories", owner: owner, forks: 0, watchers: 10)
        let searchResultCellVM = SearchResultCellVM(repo: repo)
        
        XCTAssertEqual(0, searchResultCellVM.detailsButtonAlpha)
    }
}
