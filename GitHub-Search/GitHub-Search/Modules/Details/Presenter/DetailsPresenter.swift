//
//  DetailsPresenter.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 16.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

class DetailsPresenter: DetailsPresentation {
    weak var view: DetailsView?
    var interactor: DetailsUseCase?
    var router: DetailsWireFrame?
    
    func homeButtonClicked() {
        router?.PresentHomeVC()
    }
    
    func ownerNameClicked(ownerName: String) {
        router?.presentSearchResultTVC(ownerName: ownerName)
    }
    
    func forkCellClicked(ownerName: String) {
        router?.presentSearchResultTVC(ownerName: ownerName)
    }
    
    func repoDidSet(ownerName: String, repoName: String) {
        interactor?.fetchRepositoryForks(for: 1, ownerName: ownerName, repoName: repoName)
    }
    
    func nextPageForRepoForks(page: Int, ownerName: String, repoName: String) {
        interactor?.fetchRepositoryForks(for: page, ownerName: ownerName, repoName: repoName)
    }
}

extension DetailsPresenter: DetailsInteractorOutput{
    func repoForksFetched(_ repos: [Repository]) {
        view?.stopIndicators()
        view?.nextPage = 2
        
        if repos.count < 30{
            view?.isLastPage = true
        }else{
            view?.isLastPage = false
        }
        
        var users: [User] = []
        for repo in repos{
            users.append(repo.owner)
        }
        
        view?.showRepoForks(users: users)
    }
    
    func nextPageFetched(_ repos: [Repository]) {
        view?.stopIndicators()
        view?.nextPage += 1
        
        if repos.count < 30{
            view?.isLastPage = true
        }
        
        var users: [User] = []
        for repo in repos{
            users.append(repo.owner)
        }
        
        view?.showNextPage(users: users)
    }
    
    func fetchFailed(error: HTTPError) {
        view?.stopIndicators()
        view?.showErrorAlert(error: error)
    }
}
