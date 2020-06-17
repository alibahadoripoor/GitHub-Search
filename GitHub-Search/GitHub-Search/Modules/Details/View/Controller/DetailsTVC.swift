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

    var presenter: DetailsPresentation!
    var isLastPage = false
    var nextPage = 1
    
    private var topIndicator = UIRefreshControl()
    private var centerIndicator = UIActivityIndicatorView(style: .white)
    private var bottomIndicator = UIActivityIndicatorView(style: .white)

    private let header = DetailsHeaderView()
    private var cells: [User] = []
    
    
    var repo: Repository? {
        didSet{
            guard let repo = repo else { return }
            header.repo = repo
            presenter.repoDidSet(ownerName: repo.owner.login, repoName: repo.name)
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
        cell.user = cells[indexPath.item]
        cell.parentVC = self
        cell.indexPath = indexPath
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItemIndex = cells.count - 1
        
        if indexPath.item == lastItemIndex && !isLastPage{
            self.tableView.tableFooterView?.isHidden = false
            guard let repo = repo else { return }
            presenter.nextPageForRepoForks(page: nextPage, ownerName: repo.owner.login, repoName: repo.name)
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

extension DetailsTVC: DetailsView{
    func showRepoForks(users: [User]) {
        cells = users
        tableView.reloadData()
    }
    
    func showNextPage(users: [User]) {
        cells += users
        tableView.reloadData()
    }
    
    func stopIndicators() {
        tableView.tableFooterView?.isHidden = true
        centerIndicator.stopAnimating()
        topIndicator.endRefreshing()
    }
    
    func showErrorAlert(error: HTTPError) {
        //we can handel the errors here
        debugPrint("Error: \(error.localizedDescription)")
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
        
        let homeBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Home"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.rightBarButtonItem = homeBarButtonItem
        
        if navigationController?.viewControllers.count == 2 {
            title = "Details"
        }else{
            title = repo?.name
        }
        
    }
    
    private func setupIndicators(){
        topIndicator.addTarget(self, action: #selector(reloadDetails), for: .valueChanged)
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
    
    @objc dynamic private func reloadDetails(){
        guard let repo = repo else { return }
        presenter.repoDidSet(ownerName: repo.owner.login, repoName: repo.name)
    }
    
    @objc private func leftBarButtonClicked(){
        presenter.homeButtonClicked()
    }
    
    func showSearchResultTVC(for user: User, indexPath: IndexPath?){
        if let indexPath = indexPath{
            tableView.deselectRow(at: indexPath, animated: false)
            presenter.forkCellClicked(ownerName: user.login)
        }else{
            guard let repo = repo else { return }
            presenter.ownerNameClicked(ownerName: repo.owner.login)
        }
    }
    
}
