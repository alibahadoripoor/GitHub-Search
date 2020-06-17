//
//  SearchResultProtocols.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 11.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation
import UIKit.UIViewController

protocol SearchResultView: class{
    var presenter: SearchResultPresentation! { get set }
    var isLastPage: Bool { get set }
    var nextPage: Int { get set }
    
    func showSearchResults(object: Object)
    func showUserRepos(repos: [Repository])
    func showNextPage(repos: [Repository])
    func stopIndicators()
    func showBackgroundImage()
    func showErrorAlert(error: HTTPError)
}

protocol SearchResultUseCase: class {
    var output: SearchResultInteractorOutput! { get set }
    
    func fetchRepositoriesObject(for page: Int, query: String)
    func fetchUserRepositories(for page: Int, ownerName: String)
}

protocol SearchResultInteractorOutput: class {
    func searchResultObjectFetched(_ object: Object)
    func userReposFetched(_ repos: [Repository])
    func nextPageFetched(_ repos: [Repository])
    func fetchFailed(error: HTTPError)
}

protocol SearchResultPresentation: class {
    var view: SearchResultView? { get set }
    var interactor: SearchResultUseCase? { get set }
    var router: SearchResultWireFrame? { get set }
    
    func searchButtonClicked()
    func homeButtonClicked()
    func detailsButtonClicked(for repo: Repository)
    func searchQueryDidSet(query: String)
    func searchUserNameDidSet(ownerName: String)
    func nextPageForQuerySearchResult(page: Int, query: String)
    func nextPageForUserRepos(page: Int, ownerName: String)
}

protocol SearchResultWireFrame: class {
    var viewController: UIViewController? { get set }
    
    func presentDetails(repo: Repository)
    func presentSearchVC()
    func PresentHomeVC()
    
    func assembleModule() -> UIViewController
}




