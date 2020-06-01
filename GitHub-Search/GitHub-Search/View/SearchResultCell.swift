//
//  SearchResultCell.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 31.05.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

class SearchResultCell: BaseCell{

    weak var parentVC: SearchResultTVC!
    
    var repo: SearchResultCellVM? {
        didSet{
            guard let repo = repo else { return }
            
            self.titleLabel.text = repo.name
            self.profileImageView.setImage(for: repo.owner.avatar_url)
            self.forksAndWatchersLabel.text = "\(repo.forks) Forks   \(repo.watchers) Watchers"
            self.desLabel.text = repo.description ?? " "
            
            if repo.forks > 0{
                self.detailsButton.alpha = 1
            }else{
                self.detailsButton.alpha = 0
            }
        }
    }
    
    var isUserRepoCell: Bool = false{
        didSet{
            if isUserRepoCell {
                self.detailsButton.alpha = 0
            }else{
                self.detailsButton.alpha = 1
            }
        }
    }
    
    private let customBackgroundView = UIView()
    private let topView = UIView()
    private let profileImageView = UIImageView()
    private let titleLabel = UILabel()
    private let detailsButton = UIButton(type: .system)
    private let desLabel = UILabel()
    private let forksAndWatchersLabel = UILabel()
    
    override func SetupViews(){
        
        self.backgroundColor = .clear
        setupCustomBackgroundView()
        setupTopView()
        setupForksAndWatchersLabel()
        setupDesLabel()
        
    }
    
    private func setupCustomBackgroundView(){
        addSubview(customBackgroundView)
        
        customBackgroundView.backgroundColor = .customLightBlue
        customBackgroundView.layer.cornerRadius = 5
        customBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customBackgroundView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            customBackgroundView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            customBackgroundView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            customBackgroundView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupTopView(){
        customBackgroundView.addSubview(topView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: customBackgroundView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: customBackgroundView.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: customBackgroundView.heightAnchor, multiplier: 0.6)
        ])
        
        setupProfileImageView()
        setupDetailsButton()
        setupTitleLabel()
    }
    
    private func setupProfileImageView(){
        topView.addSubview(profileImageView)
        
        profileImageView.image = UIImage()
        profileImageView.layer.borderColor = UIColor.customYellow.cgColor
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.cornerRadius = 31
        profileImageView.layer.masksToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10),
            profileImageView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10),
            profileImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10),
            profileImageView.widthAnchor.constraint(equalToConstant: 62)
        ])
    }
    
    private func setupTitleLabel(){
        topView.addSubview(titleLabel)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor.white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: detailsButton.leadingAnchor, constant: -10)
        ])
    }
    
    private func setupDetailsButton(){
        topView.addSubview(detailsButton)
        
        detailsButton.setImage(#imageLiteral(resourceName: "Details").withRenderingMode(.alwaysOriginal), for: .normal)
        detailsButton.addTarget(self, action: #selector(detailsButtonClicked), for: .touchUpInside)
        detailsButton.contentMode = .scaleAspectFit
        detailsButton.layer.masksToBounds = true
        detailsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailsButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10),
            detailsButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10),
            detailsButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10),
            detailsButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupDesLabel(){
        customBackgroundView.addSubview(desLabel)
        
        desLabel.font = .systemFont(ofSize: 14)
        desLabel.textColor = .white
        desLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            desLabel.topAnchor.constraint(equalTo: topView.bottomAnchor),
            desLabel.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor, constant: 10),
            desLabel.trailingAnchor.constraint(equalTo: customBackgroundView.trailingAnchor, constant: -10),
            desLabel.bottomAnchor.constraint(equalTo: forksAndWatchersLabel.topAnchor)
        ])
    }
    
    private func setupForksAndWatchersLabel(){
        customBackgroundView.addSubview(forksAndWatchersLabel)
        
        forksAndWatchersLabel.font = .boldSystemFont(ofSize: 14)
        forksAndWatchersLabel.textColor = .customYellow
        forksAndWatchersLabel.textAlignment = .right
        forksAndWatchersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            forksAndWatchersLabel.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor, constant: 10),
            forksAndWatchersLabel.trailingAnchor.constraint(equalTo: customBackgroundView.trailingAnchor, constant: -10),
            forksAndWatchersLabel.heightAnchor.constraint(equalToConstant: 20),
            forksAndWatchersLabel.bottomAnchor.constraint(equalTo: customBackgroundView.bottomAnchor, constant: -10)
        ])
    }
    
    @objc private func detailsButtonClicked(){
        guard let repo = repo else { return }
        parentVC.showDetailsTVC(for: repo)
    }
}
