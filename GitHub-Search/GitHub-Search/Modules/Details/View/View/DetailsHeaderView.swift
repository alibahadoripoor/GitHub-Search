//
//  DetailsHeaderView.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 01.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

class DetailsHeaderView: BaseView {
    
    weak var paretVC: DetailsTVC!
    var imageLoader = ProfileImageLoader()
    
    var repo: Repository?{
        didSet{
            guard let repo = repo else { return }
            userNameButton.setTitle(repo.owner.login, for: .normal)
            repoNameLabel.text = repo.name
            
            imageLoader.getProfileImage(for: repo.owner.avatar_url)
            imageLoader.image.bind { [weak self] (image) in
                guard let self = self else { return }
                self.profileImageView.image = image
                self.setNeedsDisplay()
            }
        }
    }
    
    private let profileImageView = UIImageView()
    private let userNameButton = UIButton(type: .system)
    private let repoNameLabel = UILabel()
    
    override func setupViews() {
        self.backgroundColor = .clear
        setupProfileImageView()
        setupUserNameButton()
        setupRepoNameLabel()
    }
    
    private func setupProfileImageView(){
        addSubview(profileImageView)
        
        profileImageView.image = UIImage()
        profileImageView.layer.borderColor = UIColor.customYellow.cgColor
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.cornerRadius = 50
        profileImageView.layer.masksToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            profileImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupUserNameButton(){
        addSubview(userNameButton)
        
        userNameButton.titleLabel?.font = .boldSystemFont(ofSize: 24)
        userNameButton.tintColor = .customYellow
        userNameButton.addTarget(self, action: #selector(userNameButtonButtonClicked), for: .touchUpInside)
        userNameButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userNameButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            userNameButton.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            userNameButton.trailingAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupRepoNameLabel(){
        addSubview(repoNameLabel)
        
        repoNameLabel.text = "Not Repository Searched Yet"
        repoNameLabel.font = .systemFont(ofSize: 22)
        repoNameLabel.textColor = .white
        repoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repoNameLabel.topAnchor.constraint(equalTo: userNameButton.bottomAnchor),
            repoNameLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            repoNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            repoNameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func userNameButtonButtonClicked(){
        guard let repo = repo else { return }
        paretVC.showSearchResultTVC(for: repo.owner, indexPath: nil)
    }
}
