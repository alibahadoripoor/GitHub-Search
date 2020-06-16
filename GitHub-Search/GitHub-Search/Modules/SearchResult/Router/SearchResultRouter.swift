//
//  SearchResultRouter.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 11.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit.UIViewController

class SearchResultRouter: SearchResultWireFrame {
    
    weak var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        let view = SearchResultTVC()
        let presenter = SearchResultPresenter()
        let interactor = SearchResultInteractor()
        let router = SearchResultRouter()
                
        let navigationController = UINavigationController(rootViewController: view)
        navigationController.navigationBar.prefersLargeTitles = true
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = view
        
        return navigationController
    }
    
    func presentDetails() {
        
    }
    
    func presentSearchVC() {
        let searchVC = SearchRouter.assembleModule()
        viewController?.present(searchVC, animated: true, completion: nil)
    }
    
    func PresentHomeVC(){
        guard let homeVC = viewController?.navigationController?.viewControllers[0] else { return }
        viewController?.navigationController?.popToViewController(homeVC, animated: true)
    }
}
