//
//  SearchProtocols.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 16.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation
import UIKit.UIViewController

protocol SearchView: class{
    var presenter: SearchPresentation! { get set }
    
}

protocol SearchPresentation: class {
    var view: SearchView? { get set }
    var router: SearchWireFrame? { get set }
    
    func searchButtonClicked(with searchText: String)
    func cancelButtonClicked()
}

protocol SearchWireFrame: class {
    var viewController: UIViewController? { get set }
    
    static func assembleModule() -> UIViewController
    
    func presentSearchResultsTVC(with searchText: String?)
}

