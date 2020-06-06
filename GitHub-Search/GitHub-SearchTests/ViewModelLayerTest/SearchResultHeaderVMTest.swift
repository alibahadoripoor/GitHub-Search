//
//  SearchResultHeaderVMTest.swift
//  GitHub-SearchTests
//
//  Created by Ali Bahadori on 02.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import XCTest
@testable import GitHub_Search

class SearchResultHeaderVMTest: XCTestCase {

    func testSearchResultHeaderVM() {
        let searchResultHeaderVM = SearchResultHeaderVM(totalCount: 10, searchText: "iOS App")
        XCTAssertEqual("10 items for: iOS App", searchResultHeaderVM.headerText)
    }
    
    func testCourseViewModelLessonsOverThreshold() {
        let searchResultHeaderVM = SearchResultHeaderVM(totalCount: nil, searchText: "ali bahadori")
        XCTAssertEqual("ali bahadori Repositories", searchResultHeaderVM.headerText)
    }

}
