//
//  Service.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 28.05.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//


import Foundation

enum HTTPError: Error {
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
}


typealias ObjectCompletion = (Object?, HTTPError?) -> ()
typealias ReposCompletion = ([Repository]?, HTTPError?) -> ()

protocol RepositoriesServiceProtocol: class {
    func getRepositoriesObject(for page: Int, query: String, completion: @escaping ObjectCompletion)
    func getRepositoryForks(for ownerName: String, repoName: String, page: Int, completion: @escaping ReposCompletion)
    func getUserRepositories(for ownerName: String, page: Int, completion: @escaping ReposCompletion)
}

class RepositoriesService: RepositoriesServiceProtocol {
    
    private var urlBuilder: URLComponents = {
        var urlBuilder = URLComponents()
        urlBuilder.scheme = "https" 
        urlBuilder.host = "api.github.com"
        return urlBuilder
    }()
    
    func getRepositoriesObject(for page: Int, query: String, completion: @escaping ObjectCompletion) {
        
        urlBuilder.path = "/search/repositories"
        urlBuilder.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "q", value: "\(query)")
        ]
        
        let url = urlBuilder.url!
   
        DataService.fetchData(for: url) { (data, err) in
            
            guard err == nil else{
                completion(nil, err)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let object: Object = try decoder.decode(Object.self, from: data)
                completion(object, nil)
            } catch {
                print("Unable to decode data: \(error.localizedDescription)")
                completion(nil, .invalidData)
            }
            
        }

    }

    func getRepositoryForks(for ownerName: String, repoName: String, page: Int, completion: @escaping ReposCompletion){
        
        urlBuilder.path = "/repos/\(ownerName)/\(repoName)/forks"
        urlBuilder.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        let url = urlBuilder.url!
        
        DataService.fetchData(for: url) { (data, err) in
            
            guard err == nil else{
                completion(nil, err)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let repositoryForks: [Repository] = try decoder.decode([Repository].self, from: data)
                completion(repositoryForks, nil)
            } catch {
                print("Unable to decode data: \(error.localizedDescription)")
                completion(nil, .invalidData)
            }
            
        }
        
    }
   
    func getUserRepositories(for ownerName: String, page: Int, completion: @escaping ReposCompletion){
        
        urlBuilder.path = "/users/\(ownerName)/repos"
        urlBuilder.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        let url = urlBuilder.url!
        
        DataService.fetchData(for: url) { (data, err) in
            
            guard err == nil else{
                completion(nil, err)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let userRepositories: [Repository] = try decoder.decode([Repository].self, from: data)
                completion(userRepositories, nil)
            } catch {
                print("Unable to decode data: \(error.localizedDescription)")
                completion(nil, .invalidData)
            }
            
        }
        
    }
    
}
