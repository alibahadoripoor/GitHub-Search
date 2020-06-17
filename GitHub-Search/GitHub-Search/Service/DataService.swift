//
//  DataService.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 06.06.20.
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

class DataService{
    
    private static let session: URLSession = .shared
   
    static func fetchData(for url: URL, completion: @escaping (Data?, HTTPError?) -> ()){
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
