//
//  DetailsRouter.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 16.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit.UIViewController

class DetailsRouter: DetailsWireFrame {
    weak var viewController: UIViewController?
    
    func presentSearchResultTVC(ownerName: String) {
        let searchResultTVC = SearchResultRouter().assembleModule() as! SearchResultTVC
        searchResultTVC.searchUserName = ownerName
        viewController?.navigationController?.pushViewController(searchResultTVC, animated: true)
    }
    
    func PresentHomeVC() {
        guard let homeVC = viewController?.navigationController?.viewControllers[0] else { return }
        viewController?.navigationController?.popToViewController(homeVC, animated: true)
    }
    
    func assembleModule() -> UIViewController {
        let view = DetailsTVC(style: .grouped)
        let presenter = DetailsPresenter()
        let interactor = DetailsInteractor()
        let router = DetailsRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = view
        
        return view
    }
}
