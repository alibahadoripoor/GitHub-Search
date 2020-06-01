//
//  DetailsVM.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 30.05.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

class DetailsVM{
    
    let isLastPage: Box<Bool?> = Box(nil)
    let fetchedCells: Box<[DetailsForkCellVM]?> = Box(nil)
    
    public func loadRepositoriesForks(for userName: String,repoName: String, page: Int){
        RepositoriesService.getRepositoryForks(for: userName, repoName: repoName, page: page) { [weak self] (repos, err) in
            guard let self = self, let repos = repos else {return}
            
            if repos.isEmpty {
                self.isLastPage.value = true
            }
            
            let cells = repos.map({ return DetailsForkCellVM(user: $0.owner) })
            self.fetchedCells.value = cells
        }
    }
    
}
