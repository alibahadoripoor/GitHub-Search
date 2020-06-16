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
        window.makeKeyAndVisible()
        window.rootViewController = SearchResultRouter.assembleModule()
    }
}
