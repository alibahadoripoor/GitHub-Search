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

extension UIImageView {
   
    func setImage(for urlString: String){
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            //if the image already exist in the cache, set image from cache and return
            self.image = imageFromCache
            return
        }
        
        RepositoriesService.getProfileImageData(for: urlString) { [weak self] (data, err) in
            guard let self = self, let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            self.image = image
            self.setNeedsDisplay()
            
            //Save the imageUrl in the cache
            imageCache.setObject(image, forKey: urlString as NSString)
        }
        
    }
    
}
