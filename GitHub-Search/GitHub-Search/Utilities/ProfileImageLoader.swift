//
//  CustomImageView.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 31.05.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation
import UIKit.UIImageView

//Creating the cache object
let imageCache = NSCache<NSString, UIImage>()

class ProfileImageLoader{
   
    private var service: ProfileImageServiceProtocol!
    var image: Box<UIImage?> = Box(nil)
    
    init(service: ProfileImageServiceProtocol = ProfileImageService()) {
        self.service = service
    }
    
    func getProfileImage(for urlString: String){
        
        image.value = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            //if the image already exist in the cache, set image from cache and return
            self.image.value = imageFromCache
            return
        }
        
        guard let service = service else { return }
        service.getProfileImageData(for: urlString) { [weak self] (data, err) in
            guard let self = self, let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            self.image.value = image
            
            //Save the imageUrl in the cache
            imageCache.setObject(image, forKey: urlString as NSString)
        }
        
    }
    
}
