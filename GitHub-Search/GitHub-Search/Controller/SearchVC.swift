//
//  SearchViewController.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 30.05.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    weak var searchResultTVC: SearchResultTVC!
    
    private let topView = UIView()
    private let cancelButton = UIButton(type: .system)
    private let githubImageView = UIImageView()
    private let searchView = UISearchBar()
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
        searchView.becomeFirstResponder()
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
        view.addSubview(searchView)
        
        searchView.delegate = self
        searchView.keyboardAppearance = .dark
        searchView.layer.borderColor = UIColor.customYellow.cgColor
        searchView.barTintColor = .customDarkBlue
        searchView.tintColor = .customYellow
        searchView.searchTextField.leftView?.tintColor = .customYellow
        searchView.searchTextField.textColor = .white
        searchView.layer.borderWidth = 3
        searchView.layer.cornerRadius = 5
        searchView.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        searchView.placeholder = "Search Repository"
        searchView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            searchView.heightAnchor.constraint(equalToConstant: 50)
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
            searchButton.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 10),
            searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func searchButtonClicked(){
        self.searchResultTVC.searchQuery = self.searchBarText
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancelButtonClicked(){
        self.dismiss(animated: true, completion: nil)
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
