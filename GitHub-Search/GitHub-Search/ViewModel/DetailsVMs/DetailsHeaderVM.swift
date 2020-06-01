//
//  DetailsHeaderVM.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 01.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

class DetailsHeaderVM {
    let userName: String
    let repoName: String
    let imageURL: String
    
    init(repo: SearchResultCellVM) {
        self.userName = repo.owner.login
        self.repoName = repo.name
        self.imageURL = repo.owner.avatar_url
    }
}
