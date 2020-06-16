//
//  SearchResultInteractor.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 11.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

class SearchResultInteractor: SearchResultUseCase {
    weak var output: SearchResultInteractorOutput!
    
    private var urlBuilder: URLComponents = {
        var urlBuilder = URLComponents()
        urlBuilder.scheme = "https"
        urlBuilder.host = "api.github.com"
        return urlBuilder
    }()
    
    func fetchRepositoriesObject(for page: Int, query: String) {
        
        urlBuilder.path = "/search/repositories"
        urlBuilder.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "q", value: "\(query)")
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
                let object: Object = try decoder.decode(Object.self, from: data)
                
                if page == 1 {
                    self.output.searchResultObjectFetched(object)
                }else{
                    self.output.nextPageFetched(object.items)
                }
                
            } catch {
                print("Unable to decode data: \(error.localizedDescription)")
                self.output.fetchFailed(error: .invalidData)
            }
            
        }
        
    }
    
    func fetchUserRepositories(for page: Int, ownerName: String){
        
        urlBuilder.path = "/users/\(ownerName)/repos"
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
                let userRepos: [Repository] = try decoder.decode([Repository].self, from: data)
                
                if page == 1 {
                    self.output.userReposFetched(userRepos)
                }else{
                    self.output.nextPageFetched(userRepos)
                }
                
            } catch {
                print("Unable to decode data: \(error.localizedDescription)")
                self.output.fetchFailed(error: .invalidData)
            }
            
        }
        
    }
    
}
