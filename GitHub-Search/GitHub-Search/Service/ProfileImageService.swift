//
//  ProfileImageService.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 06.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

typealias ProfileImageCompletion = (Data?, HTTPError?) -> ()

protocol ProfileImageServiceProtocol {
    func getProfileImageData(for avatarURL: String, completion: @escaping ProfileImageCompletion)
}

class ProfileImageService: ProfileImageServiceProtocol{
    
    func getProfileImageData(for avatarURL: String, completion: @escaping (Data?, HTTPError?) -> ()){
        
        guard let url = URL(string: avatarURL) else { return }
        
        DataService.fetchData(for: url) { (data, err) in
            
            guard err == nil else{
                completion(nil, err)
                return
            }
            
            guard let data = data else { return }
            completion(data, nil)
        }
        
    }
    
}
