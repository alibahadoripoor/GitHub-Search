//
//  SearchResultPresenter.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 11.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

class SearchResultPresenter: SearchResultPresentation{
    weak var view: SearchResultView?
    var interactor: SearchResultUseCase?
    var router: SearchResultWireFrame?
    
    func searchButtonClicked() {
        router?.presentSearchVC()
    }

    func homeButtonClicked() {
        router?.PresentHomeVC()
    }

    func searchQueryDidSet(query: String) {
        interactor?.fetchRepositoriesObject(for: 1, query: query)
    }
    
    func nextPageForQuerySearchResult(page: Int , query: String) {
        interactor?.fetchRepositoriesObject(for: page, query: query)
    }
    
    func searchUserNameDidSet(ownerName: String) {
        interactor?.fetchUserRepositories(for: 1, ownerName: ownerName)
    }
    
    func nextPageForUserRepos(page: Int, ownerName: String) {
        interactor?.fetchUserRepositories(for: page, ownerName: ownerName)
    }
}

extension SearchResultPresenter: SearchResultInteractorOutput{
    func searchResultObjectFetched(_ object: Object) {
        view?.stopIndicators()
        view?.nextPage = 2
        
        if object.items.isEmpty{
            view?.showBackgroundImage()
        }
        
        if object.items.count < 30{
            view?.isLastPage = true
        }else{
            view?.isLastPage = false
        }
        
        view?.showSearchResults(object: object)
    }
    
    func userReposFetched(_ repos: [Repository]) {
        view?.stopIndicators()
        view?.nextPage = 2
        
        if repos.isEmpty{
            view?.showBackgroundImage()
        }
        
        if repos.count < 30{
            view?.isLastPage = true
        }else{
            view?.isLastPage = false
        }
        
        view?.showUserRepos(repos: repos)
    }
    
    func nextPageFetched(_ repos: [Repository]) {
        view?.stopIndicators()
        view?.nextPage += 1
        
        if repos.count < 30{
            view?.isLastPage = true
        }
        
        view?.showNextPage(repos: repos)
    }
    
    func fetchFailed(error: HTTPError) {
        view?.stopIndicators()
        view?.showErrorAlert(error: error)
    }
}
