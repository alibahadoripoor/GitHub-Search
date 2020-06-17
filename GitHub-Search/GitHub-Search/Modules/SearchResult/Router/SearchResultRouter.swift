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
    
    func assembleModule() -> UIViewController {
        let view = SearchResultTVC()
        let presenter = SearchResultPresenter()
        let interactor = SearchResultInteractor()
        let router = SearchResultRouter()
                
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = view
        
        return view
    }
    
    func presentDetails(repo: Repository) {
        let detailsTVC = DetailsRouter().assembleModule() as! DetailsTVC
        detailsTVC.repo = repo
        viewController?.navigationController?.pushViewController(detailsTVC, animated: true)
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
