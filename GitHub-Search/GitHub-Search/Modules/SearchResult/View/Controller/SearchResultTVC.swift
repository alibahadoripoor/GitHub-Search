//
//  SearchResultTVC.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 30.05.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

private let searchCellId = "searchCellId"

class SearchResultTVC: UITableViewController {

    var presenter: SearchResultPresentation!
    var nextPage = 1
    var isLastPage = false
    
    private var topIndicator = UIRefreshControl()
    private var centerIndicator = UIActivityIndicatorView(style: .white)
    private var bottomIndicator = UIActivityIndicatorView(style: .white)
    private let backImageView = UIImageView(image: #imageLiteral(resourceName: "Github-back"))
    
    private let header = SearchResultHeaderView()
    private var cells: [Repository] = []
    private var isFirstLoad = true
    
    var searchQuery: String?{
        didSet{
            guard let searchQuery = searchQuery else { return }
            backImageView.alpha = 0
            presenter.searchQueryDidSet(query: searchQuery)
            if #available(iOS 13.0, *){
                centerIndicator.startAnimating()
            }
        }
    }
    
    var searchUserName: String?{
        didSet{
            guard let searchUserName = searchUserName else { return }
            backImageView.alpha = 0
            presenter.searchUserNameDidSet(ownerName: searchUserName)
            if #available(iOS 13.0, *){
                centerIndicator.startAnimating()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigation()
        setupIndicators()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if navigationController?.viewControllers.count == 1 {
            if isFirstLoad {
                presenter.searchButtonClicked()
                isFirstLoad = false
            }
        }
        
    }
    
    deinit{
        debugPrint("Not Any Retain Cycle For SearchResultTVC")
    }
    
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: searchCellId, for: indexPath) as! SearchResultCell
        cell.repo = cells[indexPath.item]
        cell.parentVC = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastItemIndex = cells.count - 1
        
        if indexPath.item == lastItemIndex && !isLastPage{
            self.tableView.tableFooterView?.isHidden = false
            if navigationController?.viewControllers.count == 1 {
                presenter.nextPageForQuerySearchResult(page: nextPage, query: searchQuery!)
            }else{
                presenter.nextPageForUserRepos(page: nextPage, ownerName: searchUserName!)
            }
        }
        
    }
    
}

extension SearchResultTVC: SearchResultView{
    func showSearchResults(object: Object) {
        header.setupTextLabel(for: searchQuery!, totalCount: object.total_count)
        cells = object.items
        tableView.reloadData()
    }
    
    func showUserRepos(repos: [Repository]) {
        header.setupTextLabel(userName: searchUserName!)
        cells = repos
        tableView.reloadData()
    }
    
    func showNextPage(repos: [Repository]) {
        cells += repos
        tableView.reloadData()
    }
    
    func stopIndicators() {
        tableView.tableFooterView?.isHidden = true
        centerIndicator.stopAnimating()
        topIndicator.endRefreshing()
    }
    
    func showBackgroundImage(){
        backImageView.alpha = 1
    }
    
    func showErrorAlert(error: HTTPError) {
        //Here we can Handel the errors
        debugPrint("Error: \(error.localizedDescription)")
    }
}

extension SearchResultTVC{
    
    private func setupTableView(){
        
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: searchCellId)
        tableView.backgroundColor = .customDarkBlue
        tableView.rowHeight = 145
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        backImageView.contentMode = .scaleAspectFit
        tableView.backgroundView = backImageView
        
    }
    
    private func setupNavigation(){

        if navigationController?.viewControllers.count == 1 {
            title = "Search Results"
            let searchBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
            navigationItem.rightBarButtonItem = searchBarButtonItem
        }else{
            title = searchUserName
            let homeBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Home"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
            navigationItem.rightBarButtonItem = homeBarButtonItem
        }
        
    }
    
    private func setupIndicators(){
        topIndicator.addTarget(self, action: #selector(reloadResults), for: .valueChanged)
        topIndicator.tintColor = .white
        tableView.refreshControl = topIndicator
        
        view.addSubview(centerIndicator)
        guard let navHeight = navigationController?.navigationBar.frame.height else { return }
        centerIndicator.frame = CGRect(x: 0, y: -navHeight, width: view.frame.width, height: view.frame.height)
        centerIndicator.hidesWhenStopped = true
        
        bottomIndicator.startAnimating()
        bottomIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        tableView.tableFooterView = bottomIndicator
        tableView.tableFooterView?.isHidden = true
    }
    
    @objc private func leftBarButtonClicked(){
        if navigationController?.viewControllers.count == 1 {
            presenter.searchButtonClicked()
        }else{
            presenter.homeButtonClicked()
        }
    }
    
    @objc dynamic private func reloadResults(){
        if navigationController?.viewControllers.count == 1 {
            presenter.nextPageForQuerySearchResult(page: 1, query: searchQuery!)
        }else{
            presenter.nextPageForUserRepos(page: 1, ownerName: searchUserName!)
        }
    }
    
    func showDetailsTVC(for repo: Repository){
        presenter.detailsButtonClicked(for: repo)
    }
    
}
