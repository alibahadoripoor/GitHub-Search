//
//  SearchPresenter.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 16.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

class SearchPresenter: SearchPresentation{
    weak var view: SearchView?
    var router: SearchWireFrame?
    
    func searchButtonClicked(with searchText: String){
        if searchText == "" { return }
        router?.presentSearchResultsTVC(with: searchText)
    }
    
    func cancelButtonClicked() {
        router?.presentSearchResultsTVC(with: nil)
    }
}

