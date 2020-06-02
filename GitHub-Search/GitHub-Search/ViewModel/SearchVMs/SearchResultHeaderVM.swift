//
//  SearchResultHeaderVM.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 01.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

class SearchResultHeaderVM{
    let headerText: String
    
    init(totalCount: Int?, searchText: String) {
        if let totalCount = totalCount{
            self.headerText = "\(totalCount) items for: \(searchText)"
        }else{
            self.headerText = "\(searchText) Repositories"
        }
    }
}
