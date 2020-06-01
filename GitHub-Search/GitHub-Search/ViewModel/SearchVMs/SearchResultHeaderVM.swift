//
//  SearchResultHeaderVM.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 01.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

class SearchResultHeaderVM{
    let searchText: String
    let totalCount: Int?
    
    init(totalCount: Int?, searchText: String) {
        self.totalCount = totalCount
        self.searchText = searchText
    }
}
