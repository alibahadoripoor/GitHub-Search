//
//  SearchViewController.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 30.05.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, SearchView {

    var presenter: SearchPresentation!
    
    private let topView = UIView()
    private let cancelButton = UIButton(type: .system)
    private let githubImageView = UIImageView()
    private let searchBar = UISearchBar()
    private let searchButton = UIButton(type: .system)
    private var searchBarText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .customDarkBlue
        
        setupTopView()
        setupSearchView()
        setupSearchButton()
        hideKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    deinit{
        debugPrint("Not Any Retain Cycle For SearchVC")
    }
   
}

extension SearchVC{
    private func setupTopView(){
        view.addSubview(topView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4)
        ])
        
        setupCancelButton()
        setupGithubImageView()
    }
    
    private func setupCancelButton(){
        topView.addSubview(cancelButton)
        
        cancelButton.setImage(#imageLiteral(resourceName: "Cancel"), for: .normal)
        cancelButton.tintColor = .customLightBlue
        cancelButton.contentMode = .scaleAspectFit
        cancelButton.addTarget(self, action: #selector(self.cancelButtonClicked), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            cancelButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupGithubImageView(){
        topView.addSubview(githubImageView)
        
        githubImageView.image = #imageLiteral(resourceName: "Github")
        githubImageView.contentMode = .scaleAspectFit
        githubImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            githubImageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            githubImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 70),
            githubImageView.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor),
            githubImageView.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.6)
        ])
    }
    
    private func setupSearchView(){
        view.addSubview(searchBar)
        
        searchBar.delegate = self
        searchBar.keyboardAppearance = .dark
        searchBar.layer.borderColor = UIColor.customYellow.cgColor
        searchBar.barTintColor = .customDarkBlue
        searchBar.tintColor = UIColor.customYellow
        searchBar.textField.leftView?.tintColor = .customYellow
        searchBar.textField.textColor = .white
        searchBar.textField.backgroundColor = .clear
        searchBar.layer.borderWidth = 3
        searchBar.layer.cornerRadius = 5
        searchBar.placeholder = "Search Repository"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topView.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupSearchButton(){
        view.addSubview(searchButton)
        
        searchButton.setTitle("Search", for: .normal)
        searchButton.titleLabel?.font = .boldSystemFont(ofSize: 22)
        searchButton.tintColor = .customDarkBlue
        searchButton.backgroundColor = .customYellow
        searchButton.layer.cornerRadius = 5
        searchButton.addTarget(self, action: #selector(self.searchButtonClicked), for: .touchUpInside)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func searchButtonClicked(){
        searchBar.resignFirstResponder()
        presenter.searchButtonClicked(with: searchBarText)
    }
    
    @objc private func cancelButtonClicked(){
        searchBar.resignFirstResponder()
        presenter.cancelButtonClicked()
    }
}

extension SearchVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchBarText = searchText
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchButtonClicked()
    }
}


