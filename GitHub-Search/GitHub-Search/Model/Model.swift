//
//  RepositoriesModel.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 28.05.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

struct Object: Decodable {
    let total_count: Int?
    let items: [Repository]?
}

struct Repository: Decodable {
    let name: String?
    let description: String?
    let owner: User?
    let forks: Int?
    let watchers: Int?
}

struct User: Decodable {
    let login: String?
    let avatar_url: String?
}
