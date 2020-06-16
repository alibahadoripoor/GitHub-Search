//
//  SearchRouter.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 16.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit.UIViewController

class SearchRouter: SearchWireFrame {
    weak var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        let view = SearchVC()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        
        router.viewController = view
        
        return view
    }
    
    func presentSearchResultsTVC(with searchText: String?) {
        if let searchText = searchText{
            let searchResultNav = viewController?.presentingViewController as! UINavigationController
            let searchResultTVC = searchResultNav.viewControllers[0] as! SearchResultTVC
            searchResultTVC.searchQuery = searchText
        }
        viewController?.dismiss(animated: true, completion: nil)
    }
}
