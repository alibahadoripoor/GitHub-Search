//
//  DetailsTVC.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 30.05.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

private let forksCellId = "forksCellId"

class DetailsTVC: UITableViewController {

    private var topIndicator = UIRefreshControl()
    private var centerIndicator = UIActivityIndicatorView(style: .medium)
    private var bottomIndicator = UIActivityIndicatorView(style: .medium)
    private let viewModel = DetailsVM()
    private let header = DetailsHeaderView()
    private var cells: [DetailsForkCellVM] = []
    private var isRefreshing = false
    private var isLastPage = false
    private var nextPage = 1
    
    var detailsHeader: DetailsHeaderVM? {
        didSet{
            guard let detailsHeader = detailsHeader else { return }
            centerIndicator.startAnimating()
            header.detailsHeader = detailsHeader
            reloadDetails()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNavigation()
        setupIndicators()
        
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
            self.centerIndicator.stopAnimating()
            self.topIndicator.endRefreshing()
        }
        
        viewModel.isLastPage.bind { [weak self] (isLastPage) in
            guard let self = self, let isLastPage = isLastPage else { return }
            self.isLastPage = isLastPage
        }
        
    }

    deinit{
        debugPrint("Not Any Retain Cycle For DetailsTVC")
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: forksCellId, for: indexPath) as! DetailsForkCell
        cell.forkUser = cells[indexPath.item]
        cell.parentVC = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItemIndex = cells.count - 1
        
        if indexPath.item == lastItemIndex && !isLastPage{
            self.tableView.tableFooterView?.isHidden = false
            guard let detailsHeader = detailsHeader else { return }
            viewModel.loadRepositoriesForks(for: detailsHeader.userName, repoName: detailsHeader.repoName, page: nextPage)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        header.paretVC = self
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
}

extension DetailsTVC{
    
    private func setupTableView(){
        
        tableView.register(DetailsForkCell.self, forCellReuseIdentifier: forksCellId)
        tableView.backgroundColor = .customDarkBlue
        tableView.rowHeight = 80
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        
    }
    
    private func setupNavigation(){
        
        title = "Details"
        navigationController?.navigationBar.tintColor = .customYellow
        navigationController?.navigationBar.barTintColor = .customDarkBlue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customYellow]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customYellow]
        navigationController?.navigationBar.barStyle = .black
        
        let homeBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Home"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.rightBarButtonItem = homeBarButtonItem
        
    }
    
    private func setupIndicators(){
        topIndicator.addTarget(self, action: #selector(reloadDetails), for: .valueChanged)
        topIndicator.tintColor = .white
        tableView.refreshControl = topIndicator
        
        view.addSubview(centerIndicator)
        guard let navHeight = navigationController?.navigationBar.frame.height else { return }
        centerIndicator.frame = CGRect(x: 0, y: -navHeight, width: view.frame.width, height: view.frame.height)
        centerIndicator.hidesWhenStopped = true
        centerIndicator.color = .white
        
        bottomIndicator.startAnimating()
        bottomIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        bottomIndicator.color = .white
        tableView.tableFooterView = bottomIndicator
        tableView.tableFooterView?.isHidden = true
    }
    
    @objc dynamic private func reloadDetails(){
        guard let detailsHeader = detailsHeader else { return }
        nextPage = 1
        isRefreshing = true
        viewModel.loadRepositoriesForks(for: detailsHeader.userName, repoName: detailsHeader.repoName, page: nextPage)
    }
    
    @objc private func leftBarButtonClicked(){
        guard let homeVC = navigationController?.viewControllers[0] else { return }
        navigationController?.popToViewController(homeVC, animated: true)
    }
    
    func showSearchResultTVC(detailsHeader: DetailsHeaderVM?, forkUser: DetailsForkCellVM?){
        let searchResultTVC = SearchResultTVC()
        
        if let detailsHeader = detailsHeader{
            searchResultTVC.searchUserName = detailsHeader.userName
        }
        if let forkUser = forkUser{
            searchResultTVC.searchUserName = forkUser.userName
        }
        
        navigationController?.pushViewController(searchResultTVC, animated: true)
    }
    
}
