//
//  ModelTest.swift
//  GitHub-SearchTests
//
//  Created by Ali Bahadori on 02.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import XCTest
@testable import GitHub_Search

class ModelTest: XCTestCase {

    var exampleJSONData: Data!
    var object: Object!

    override func setUp() {
      let bundle = Bundle(for: type(of: self))
      let url = bundle.url(forResource: "Object", withExtension: "json")!
      exampleJSONData = try! Data(contentsOf: url)
    
      let decoder = JSONDecoder()
      object = try! decoder.decode(Object.self, from: exampleJSONData)
    }

    func testObjectModel(){
        XCTAssertEqual(object.total_count, 197329)
        XCTAssertEqual(object.items.count, 30)
        XCTAssertEqual(object.items[0].name, "firefox-ios")
        XCTAssertEqual(object.items[0].description, "Firefox for iOS")
        XCTAssertEqual(object.items[0].forks, 2221)
        XCTAssertEqual(object.items[0].watchers, 9390)
        XCTAssertEqual(object.items[0].owner.login, "mozilla-mobile")
        XCTAssertEqual(object.items[0].owner.avatar_url, "https://avatars3.githubusercontent.com/u/22351667?v=4")
    }

}
