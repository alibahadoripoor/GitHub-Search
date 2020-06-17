//
//  DetailsInteractor.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 16.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

class DetailsInteractor: DetailsUseCase {
    weak var output: DetailsInteractorOutput!
    
    private var urlBuilder: URLComponents = {
        var urlBuilder = URLComponents()
        urlBuilder.scheme = "https"
        urlBuilder.host = "api.github.com"
        return urlBuilder
    }()
    
    func fetchRepositoryForks(for page: Int, ownerName: String, repoName: String) {
        urlBuilder.path = "/repos/\(ownerName)/\(repoName)/forks"
        urlBuilder.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        let url = urlBuilder.url!
        
        DataService.fetchData(for: url) { [weak self] (data, err) in
            guard let self = self else { return }
            guard err == nil else{
                self.output.fetchFailed(error: err!)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let repositoryForks: [Repository] = try decoder.decode([Repository].self, from: data)
                
                if page == 1 {
                    self.output.repoForksFetched(repositoryForks)
                }else{
                    self.output.nextPageFetched(repositoryForks)
                }
                
            } catch {
                self.output.fetchFailed(error: .invalidData)
            }
            
        }
    }
}
