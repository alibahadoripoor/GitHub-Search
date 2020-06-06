//
//  DetailsHeaderVMTest.swift
//  GitHub-SearchTests
//
//  Created by Ali Bahadori on 02.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import XCTest
@testable import GitHub_Search

class DetailsHeaderVMTest: XCTestCase {
    
    func testDetailsHeaderVM(){
        let owner = User(login: "ali bahadori", avatar_url: "... image URL")
        let repo = Repository(name: "GitHub-Search", description: "An iOS app for search github Repositories", owner: owner, forks: 10, watchers: 10)
        let searchResultCellVM = SearchResultCellVM(repo: repo)
        let detailsHeaderVM = DetailsHeaderVM(repo: searchResultCellVM)
        
        XCTAssertEqual(detailsHeaderVM.userName, searchResultCellVM.owner.login)
        XCTAssertEqual(detailsHeaderVM.repoName, searchResultCellVM.name)
        XCTAssertEqual(detailsHeaderVM.imageURL, searchResultCellVM.owner.avatar_url)
    }
    
}
