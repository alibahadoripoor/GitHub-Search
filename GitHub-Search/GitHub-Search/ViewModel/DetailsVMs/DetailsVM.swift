//
//  DetailsVM.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 30.05.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

class DetailsVM{
    
    var service: RepositoriesServiceProtocol?
    
    let isLastPage: Box<Bool?> = Box(nil)
    let fetchedCells: Box<[DetailsForkCellVM]?> = Box(nil)
    
    init(service: RepositoriesServiceProtocol = RepositoriesService()) {
        self.service = service
    }
    
    public func loadRepositoriesForks(for userName: String,repoName: String, page: Int){
        guard let service = service else { return }
        service.getRepositoryForks(for: userName, repoName: repoName, page: page) { [weak self] (repos, err) in
            guard let self = self, let repos = repos else {return}
            
            if repos.count < 30 {
                self.isLastPage.value = true
            }
            
            let cells = repos.map({ return DetailsForkCellVM(user: $0.owner) })
            self.fetchedCells.value = cells
        }
    }
    
}
