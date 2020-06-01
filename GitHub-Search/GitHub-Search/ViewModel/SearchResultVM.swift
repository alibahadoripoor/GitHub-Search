//
//  SearchResultMV.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 30.05.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

class SearchResultVM{
    
    let isLastPage: Box<Bool?> = Box(nil)
    let fetchedCells: Box<[SearchResultCellVM]?> = Box(nil)

    public func loadRepositories(for query: String, page: Int){
        RepositoriesService.getRepositoriesObject(for: page, query: query) { [weak self] (object, err) in
            guard let self = self, let object = object else {return}
            
            if object.items.isEmpty {
                self.isLastPage.value = true
            }
            
            let cells = object.items.map({ return SearchResultCellVM(repo: $0) })
            self.fetchedCells.value = cells
           
        }
    }
    
    public func loadUserRepositories(for userName: String, page: Int){
        RepositoriesService.getUserRepositories(for: userName, page: page) { [weak self] (repos, err) in
            guard let self = self, let repos = repos else {return}
            
            if repos.isEmpty {
                self.isLastPage.value = true
            }
            
            let cells = repos.map({ return SearchResultCellVM(repo: $0) })
            self.fetchedCells.value = cells
            
        }
    }
    
}
