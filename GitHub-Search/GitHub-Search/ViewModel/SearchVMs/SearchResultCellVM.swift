//
//  SearchResultCellVM.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 30.05.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

class SearchResultCellVM{
    let name: String
    let description: String?
    let owner: User
    let forksWathersText: String
    let detailsButtonAlpha: Int
    
    init(repo: Repository) {
        self.name = repo.name
        self.description = repo.description
        self.owner = repo.owner
        self.forksWathersText = "\(repo.forks) Forks   \(repo.watchers) Watchers"
        
        if repo.forks > 0{
            self.detailsButtonAlpha = 1
        }else{
            self.detailsButtonAlpha = 0
        }
    }
    
}
