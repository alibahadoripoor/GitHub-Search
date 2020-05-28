//
//  ViewController.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 28.05.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //This is a sample View just for test Network and ViewModel layer
        
        viewModel.getObject()
        
        viewModel.object.bind { [weak self] (object) in
            guard let object = object else {return}
            print(object)
        }
        
        viewModel.repos.bind { [weak self] (repos) in
            guard let repos = repos else {return}
            print(repos)
        }
        
        viewModel.userRepos.bind { [weak self] (repos) in
            guard let repos = repos else {return}
            print(repos)
        }
        
    }


}

