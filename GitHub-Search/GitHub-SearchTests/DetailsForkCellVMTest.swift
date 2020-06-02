//
//  DetailsForkCellVM.swift
//  GitHub-SearchTests
//
//  Created by Ali Bahadori on 02.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import XCTest
@testable import GitHub_Search

class DetailsForkCellVMTest: XCTestCase {

    func testDetailsForkCellVM(){
        let user = User(login: "ali bahadori", avatar_url: "... image URL")
        let detailsForkCellVM = DetailsForkCellVM(user: user)
        XCTAssertEqual(detailsForkCellVM.userName, user.login)
        XCTAssertEqual(detailsForkCellVM.userImageUrl, user.avatar_url)
    }

}
