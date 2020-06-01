//
//  SearchResultTVC.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 30.05.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

class SearchResultTVC: UITableViewController {

    private let cellId = "searchCellId"
    private var bottomIndicator = UIActivityIndicatorView(style: .medium)
    private var topIndicator = UIRefreshControl()
    var isRefreshing = false
    let viewModel = SearchResultVM()
    var cells: [SearchResultCellVM] = []
    var isLastPage = false
    var nextPage = 1
    
    var searchQuery: String?{
        didSet{
            reloadResults()
        }
    }
    
    var searchUserName: String?{
        didSet{
            reloadResults()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNavigation()
        
        viewModel.fetchedCells.bind { [weak self] (cells) in
            guard let self = self, let cells = cells else { return }
            if self.isRefreshing{
                self.cells = []
                self.isRefreshing = false
            }
            self.cells += cells
            self.nextPage += 1
            self.tableView.tableFooterView?.isHidden = true
            self.tableView.reloadData()
            self.topIndicator.endRefreshing()
        }
        
        viewModel.isLastPage.bind { [weak self] (isLastPage) in
            guard let self = self, let isLastPage = isLastPage else { return }
            self.isLastPage = isLastPage
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if navigationController?.viewControllers.count == 1 {
            if searchQuery == nil, searchUserName == nil {
                showSearchVC()
            }
        }
    }
    
    deinit{
        print("we do not have any retain cycle for SearchResultTVC")
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SearchResultCell
        cell.repo = cells[indexPath.item]
        cell.parentVC = self
        if let count = navigationController?.viewControllers.count, count > 1{
            cell.isUserRepoCell = true
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastItemIndex = cells.count - 1
        
        if indexPath.item == lastItemIndex && !isLastPage{
            self.tableView.tableFooterView?.isHidden = false

            if let searchQuery = searchQuery{
                // request for searched repositories, SearcVC is ParentVC
                viewModel.loadRepositories(for: searchQuery, page: nextPage)
            }
            
            if let searchUserName = searchUserName{
                // request for user repositories, DetailsTVC is ParentVC
                viewModel.loadUserRepositories(for: searchUserName, page: nextPage)
            }
        }
        
    }

}

extension SearchResultTVC{
    
    fileprivate func setupTableView(){
        
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = .customDarkBlue
        tableView.rowHeight = 145
        tableView.allowsSelection = false
        
        
        topIndicator.addTarget(self, action: #selector(reloadResults), for: .valueChanged)
        topIndicator.tintColor = .white
        tableView.refreshControl = topIndicator
        
        bottomIndicator.startAnimating()
        bottomIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        bottomIndicator.color = .white
        tableView.tableFooterView = bottomIndicator
        tableView.tableFooterView?.isHidden = true
        
    }
    
    fileprivate func setupNavigation(){
        
        title = "Search Results"
        navigationController?.navigationBar.tintColor = .customYellow
        navigationController?.navigationBar.barTintColor = .customDarkBlue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customYellow]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customYellow]
        navigationController?.navigationBar.barStyle = .black
        
        if navigationController?.viewControllers.count == 1 {
            let searchBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Search"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
            navigationItem.rightBarButtonItem = searchBarButtonItem
        }else{
            let homeBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Home"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
            navigationItem.rightBarButtonItem = homeBarButtonItem
        }
        
    }
    
    @objc private func leftBarButtonClicked(){
        if navigationController?.viewControllers.count == 1 {
            showSearchVC()
        }else{
            guard let homeVC = navigationController?.viewControllers[0] else { return }
            navigationController?.popToViewController(homeVC, animated: true)
        }
        
    }
    
    @objc dynamic private func reloadResults(){
        if let searchQuery = searchQuery{
            // reload searched repositories, SearcVC is ParentVC
            nextPage = 1
            isRefreshing = true
            viewModel.loadRepositories(for: searchQuery, page: nextPage)
        }
        
        if let searchUserName = searchUserName{
            // reload user repositories, DetailsTVC is ParentVC
            nextPage = 1
            isRefreshing = true
            viewModel.loadUserRepositories(for: searchUserName, page: nextPage)
        }
    }
    
    func showDetailsTVC(for repo: SearchResultCellVM){
        let detailsTVC = DetailsTVC()
        detailsTVC.userName = repo.owner.login
        detailsTVC.repoName = repo.name
        navigationController?.pushViewController(detailsTVC, animated: true)
    }
    
    private func showSearchVC(){
        let searchVC = SearchVC()
        searchVC.searchResultTVC = self
        present(searchVC, animated: true)
    }
}
