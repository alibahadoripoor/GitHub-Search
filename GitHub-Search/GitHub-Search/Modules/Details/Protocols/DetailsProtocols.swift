//
//  DetailsProtocols.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 16.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation
import UIKit.UIViewController

protocol DetailsView: class{
    var presenter: DetailsPresentation! { get set }
    var isLastPage: Bool { get set }
    var nextPage: Int { get set }
    
    func showRepoForks(users: [User])
    func showNextPage(users: [User])
    func stopIndicators()
    func showErrorAlert(error: HTTPError)
}

protocol DetailsUseCase: class {
    var output: DetailsInteractorOutput! { get set }
    
    func fetchRepositoryForks(for page: Int, ownerName: String, repoName: String)
}

protocol DetailsInteractorOutput: class {
    func repoForksFetched(_ repos: [Repository])
    func nextPageFetched(_ repos: [Repository])
    func fetchFailed(error: HTTPError)
}

protocol DetailsPresentation: class {
    var view: DetailsView? { get set }
    var interactor: DetailsUseCase? { get set }
    var router: DetailsWireFrame? { get set }
    
    func homeButtonClicked()
    func ownerNameClicked(ownerName: String)
    func forkCellClicked(ownerName: String)
    func repoDidSet(ownerName: String, repoName: String)
    func nextPageForRepoForks(page: Int, ownerName: String, repoName: String)
}

protocol DetailsWireFrame: class {
    var viewController: UIViewController? { get set }
    
    func presentSearchResultTVC(ownerName: String)
    func PresentHomeVC()
    
    func assembleModule() -> UIViewController
}
