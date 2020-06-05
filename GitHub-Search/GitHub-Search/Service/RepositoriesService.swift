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

typealias fetchDataCompletion = (Data?, HTTPError?) -> ()
typealias ObjectCompletion = (Object?, HTTPError?) -> ()
typealias RepositoryForksCompletion = ([Repository]?, HTTPError?) -> ()
typealias UserRepositoriesCompletion = ([Repository]?, HTTPError?) -> ()
typealias ProfileImageCompletion = (Data?, HTTPError?) -> ()

protocol RepositoriesServiceProtocol: class {
    func getRepositoriesObject(for page: Int, query: String, completion: @escaping ObjectCompletion)
    func getRepositoryForks(for ownerName: String, repoName: String, page: Int, completion: @escaping RepositoryForksCompletion)
    func getUserRepositories(for ownerName: String, page: Int, completion: @escaping UserRepositoriesCompletion)
    func getProfileImageData(for avatarURL: String, completion: @escaping ProfileImageCompletion)
}

class RepositoriesService: RepositoriesServiceProtocol {
    
    private let session: URLSession = .shared
    
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
   
        fetchData(for: url) { (data, err) in
            
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

    func getRepositoryForks(for ownerName: String, repoName: String, page: Int, completion: @escaping RepositoryForksCompletion){
        
        urlBuilder.path = "/repos/\(ownerName)/\(repoName)/forks"
        urlBuilder.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        let url = urlBuilder.url!
        
        fetchData(for: url) { (data, err) in
            
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
   
    func getUserRepositories(for ownerName: String, page: Int, completion: @escaping UserRepositoriesCompletion){
        
        urlBuilder.path = "/users/\(ownerName)/repos"
        urlBuilder.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        let url = urlBuilder.url!
        
        fetchData(for: url) { (data, err) in
            
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
    
    func getProfileImageData(for avatarURL: String, completion: @escaping (Data?, HTTPError?) -> ()){
        
        guard let url = URL(string: avatarURL) else { return }
        
        fetchData(for: url) { (data, err) in
            
            guard err == nil else{
                completion(nil, err)
                return
            }
            
            guard let data = data else { return }
            completion(data, nil)
        }
        
    }
    
    private func fetchData(for url: URL, completion: @escaping (Data?, HTTPError?) -> ()){
        let task = session.dataTask(with: url) { (data, response, error) in
                    
            DispatchQueue.main.async {
                
                guard error == nil else {
                    print("The request is failed: \(error!.localizedDescription)")
                    completion(nil, .failedRequest)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable to process GitHub response")
                    completion(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failure response from GitHub: \(response.statusCode)")
                    completion(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No data returned from GitHub")
                    completion(nil, .noData)
                    return
                }
                
                completion(data, nil)
                
            }
            
        }
        
        task.resume()
    }
    
}
