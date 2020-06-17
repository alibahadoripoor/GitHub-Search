//
//  RootRouter.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 11.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

class RootRouter: RootWireframe {
    func presentSearchResultTVC(in window: UIWindow) {
        let searchResultTVC = SearchResultRouter().assembleModule()
        let navigationController = UINavigationController(rootViewController: searchResultTVC)
        navigationController.navigationBar.prefersLargeTitles = true
        window.makeKeyAndVisible()
        window.rootViewController = navigationController
    }
}
