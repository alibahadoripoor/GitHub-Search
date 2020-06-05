//
//  MockService.swift
//  GitHub-SearchTests
//
//  Created by Ali Bahadori on 05.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import XCTest
@testable import GitHub_Search

class MockService: RepositoriesServiceProtocol {
    
    func getRepositoriesObject(for page: Int, query: String, completion: @escaping ObjectCompletion) {
        fetchObjectData(completion: { (data,err)  in
            if let err = err {
                completion(nil, err)
                return
            }
            
            guard let data = data else{ return }
            
            do {
                let object = try JSONDecoder().decode(Object.self, from: data)
                completion(object, nil)
            }catch{
                print("the data can not decode")
            }
        })
    }
    
    func getRepositoryForks(for ownerName: String, repoName: String, page: Int, completion: @escaping RepositoryForksCompletion) {
        fetchRepositoriesData(completion: { (data,err)  in
            if let err = err {
                completion(nil, err)
                return
            }
            
            guard let data = data else{ return }
            
            do {
                let repos = try JSONDecoder().decode([Repository].self, from: data)
                completion(repos, nil)
            }catch{
                print("the data can not decode")
            }
        })
    }
    
    func getUserRepositories(for ownerName: String, page: Int, completion: @escaping UserRepositoriesCompletion) {
        fetchRepositoriesData(completion: { (data,err)  in
            if let err = err {
                completion(nil, err)
                return
            }
            
            guard let data = data else{ return }
            
            do {
                let repos = try JSONDecoder().decode([Repository].self, from: data)
                completion(repos, nil)
            }catch{
                print("the data can not decode")
            }
        })
    }
    
    func getProfileImageData(for avatarURL: String, completion: @escaping ProfileImageCompletion) {
        
    }
    
    private func fetchObjectData(completion: @escaping fetchDataCompletion){
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "Object", withExtension: "json")!
        
        do{
            let exampleJSONData = try Data(contentsOf: url)
            completion(exampleJSONData, nil)
        }catch{
            completion(nil, .noData)
        }
    }
    
    private func fetchRepositoriesData(completion: @escaping fetchDataCompletion){
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "Repositories", withExtension: "json")!
        
        do{
            let exampleJSONData = try Data(contentsOf: url)
            completion(exampleJSONData, nil)
        }catch{
            completion(nil, .noData)
        }
    }
    
}
