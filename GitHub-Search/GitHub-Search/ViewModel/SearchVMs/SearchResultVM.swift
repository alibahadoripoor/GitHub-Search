//
//  SearchResultMV.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 30.05.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

class SearchResultVM{
    
    var service: RepositoriesServiceProtocol?
    
    let fetchedHeader: Box<SearchResultHeaderVM?> = Box(nil)
    let fetchedCells: Box<[SearchResultCellVM]?> = Box(nil)
    let fetchedDetails: Box<DetailsHeaderVM?> = Box(nil)
    let isLastPage: Box<Bool?> = Box(nil)
    
    init(service: RepositoriesServiceProtocol = RepositoriesService()) {
        self.service = service
    }

    public func loadRepositories(for query: String, page: Int){
        guard let service = service else { return }
        service.getRepositoriesObject(for: page, query: query) { [weak self] (object, err) in
            guard let self = self, let object = object else {return}
            
            self.fetchedHeader.value = SearchResultHeaderVM(totalCount: object.total_count, searchText: query)
            
            let cells = object.items.map({ return SearchResultCellVM(repo: $0) })
            self.fetchedCells.value = cells
           
            if object.items.count < 30 {
                self.isLastPage.value = true
            }
        }
    }
    
    public func loadUserRepositories(for userName: String, page: Int){
        guard let service = service else { return }
        service.getUserRepositories(for: userName, page: page) { [weak self] (repos, err) in
            guard let self = self, let repos = repos else {return}
            
            self.fetchedHeader.value = SearchResultHeaderVM(totalCount: nil, searchText: userName)
            
            let cells = repos.map({ return SearchResultCellVM(repo: $0) })
            self.fetchedCells.value = cells
            
            if repos.count < 30 {
                self.isLastPage.value = true
            }
        }
    }
    
    public func fetchDetails(for repo: SearchResultCellVM){
        self.fetchedDetails.value = DetailsHeaderVM(repo: repo)
    }
    
}
