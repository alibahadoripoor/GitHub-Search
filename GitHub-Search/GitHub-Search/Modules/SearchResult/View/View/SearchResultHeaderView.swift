//
//  SearchResultHeaderView.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 01.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

class SearchResultHeaderView: BaseView {
    
//    var searchResultHeader: SearchResultHeaderVM?{
//        didSet{
//            guard let searchResultHeader = searchResultHeader else { return }
//            self.label.text = searchResultHeader.headerText
//        }
//    }
    
    let label = UILabel()
    
    override func setupViews() {
        self.backgroundColor = .customDarkBlue
        setupLabel()
    }
    
    private func setupLabel(){
        addSubview(label)
        
        label.text = "Not Repository Searched Yet"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .customYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    func setupTextLabel(for searchQuery: String, totalCount: Int){
        self.label.text = "\(totalCount) items for: \(searchQuery)"
    }
    
    func setupTextLabel(userName: String){
        self.label.text = "\(userName) Repositories"
    }
    
}
