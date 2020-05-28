//
//  ViewModel.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 28.05.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

public class ViewModel{
    
    //This is a sample ViewModel jast for test Network layer
    
    var object: Box<Object?> = Box(nil)
    var repos: Box<[Repository]?> = Box(nil)
    var userRepos: Box<[Repository]?> = Box(nil)
    
    func getObject(){
        RepositoriesService.getRepositoriesObjectFor(page: 1, query: "iOS-MVVM") { [weak self] (object, err) in
            guard let self = self, let object = object else {return}
            self.object.value = object
            
            RepositoriesService.getRepositoryForks(ownerName: object.items![0].owner!.login!, repoName: object.items![0].name!) { [weak self] (repos, err) in
                guard let self = self, let repos = repos else {return}
                self.repos.value = repos
            }
            RepositoriesService.getUserRepositories(ownerName: object.items![0].owner!.login!) { [weak self] (repos, err) in
                guard let self = self, let repos = repos else {return}
                self.userRepos.value = repos
            }
        }
    }
    
    
    
}
