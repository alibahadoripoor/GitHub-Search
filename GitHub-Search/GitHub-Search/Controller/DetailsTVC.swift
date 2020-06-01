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

    private var bottomIndicator = UIActivityIndicatorView(style: .medium)
    let viewModel = DetailsVM()
    var cells: [DetailsForkCellVM] = []
    var isLastPage = false
    var nextPage = 1
    var userName: String = ""
    var repoName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNavigation()
        
        viewModel.loadRepositoriesForks(for: userName, repoName: repoName, page: nextPage)
        
        viewModel.fetchedCells.bind { [weak self] (cells) in
            guard let self = self, let cells = cells else { return }
            self.cells += cells
            self.nextPage += 1
            self.tableView.tableFooterView?.isHidden = true
            self.tableView.reloadData()
        }
        
        viewModel.isLastPage.bind { [weak self] (isLastPage) in
            guard let self = self, let isLastPage = isLastPage else { return }
            self.isLastPage = isLastPage
        }
        
    }

    deinit{
        print("we do not have any retain cycle for DetailsTVC")
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: forksCellId, for: indexPath) as! DetailsForkCell
        cell.user = cells[indexPath.item]
        cell.parentVC = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItemIndex = cells.count - 1
        
        if indexPath.item == lastItemIndex && !isLastPage{
            self.tableView.tableFooterView?.isHidden = false
            viewModel.loadRepositoriesForks(for: userName, repoName: repoName, page: nextPage)
        }
    }
    
}

extension DetailsTVC{
    
    fileprivate func setupTableView(){
        
        tableView.register(DetailsForkCell.self, forCellReuseIdentifier: forksCellId)
        tableView.backgroundColor = .customDarkBlue
        tableView.rowHeight = 70
        tableView.allowsSelection = true
        bottomIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        bottomIndicator.color = .customYellow
        tableView.tableFooterView = bottomIndicator
        tableView.tableFooterView?.isHidden = true
        
    }
    
    fileprivate func setupNavigation(){
        
        title = "Details"
        navigationController?.navigationBar.tintColor = .customYellow
        navigationController?.navigationBar.barTintColor = .customDarkBlue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customYellow]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customYellow]
        navigationController?.navigationBar.barStyle = .black
        
        let homeBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Home"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.rightBarButtonItem = homeBarButtonItem
        
    }
    
    @objc private func leftBarButtonClicked(){
        guard let homeVC = navigationController?.viewControllers[0] else { return }
        navigationController?.popToViewController(homeVC, animated: true)
    }
    
    func showSearchResultTVC(for user: DetailsForkCellVM){
        let searchResultTVC = SearchResultTVC()
        searchResultTVC.searchUserName = user.userName
        navigationController?.pushViewController(searchResultTVC, animated: true)
    }
    
}
