//
//  ForksOwnerCellVM.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 31.05.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

class DetailsForkCellVM{
    let userName: String
    let userImageUrl: String
    
    init(user: User) {
        self.userName = user.login
        self.userImageUrl = user.avatar_url
    }
}
