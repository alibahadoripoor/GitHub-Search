//
//  DetailsCell.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 31.05.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

class DetailsForkCell: BaseCell{

    weak var parentVC: DetailsTVC!
    
    var user: DetailsForkCellVM? {
        didSet{
            guard let user = user else { return }
            self.titleLabel.text = user.userName
            self.profileImageView.setImage(for: user.userImageUrl)
        }
    }
    
    private let customBackgroundView = UIView()
    private let profileImageView = UIImageView()
    private let titleLabel = UILabel()
    private let forwardImageView = UIImageView()
    
    override func SetupViews(){
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        setupCustomBackgroundView()
        setupProfileImageView()
        setupForwardButton()
        setupTitleLabel()
        
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
    
    private func setupProfileImageView(){
        customBackgroundView.addSubview(profileImageView)
        
        profileImageView.image = UIImage()
        profileImageView.layer.borderColor = UIColor.customYellow.cgColor
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.cornerRadius = 20
        profileImageView.layer.masksToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: customBackgroundView.topAnchor, constant: 10),
            profileImageView.bottomAnchor.constraint(equalTo: customBackgroundView.bottomAnchor, constant: -10),
            profileImageView.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor, constant: 10),
            profileImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupTitleLabel(){
        customBackgroundView.addSubview(titleLabel)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor.white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: customBackgroundView.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: customBackgroundView.bottomAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: forwardImageView.leadingAnchor, constant: -10)
        ])
    }
    
    private func setupForwardButton(){
        customBackgroundView.addSubview(forwardImageView)
        
        forwardImageView.image = #imageLiteral(resourceName: "Arrow-forward")
        forwardImageView.contentMode = .scaleAspectFit
        forwardImageView.layer.masksToBounds = true
        forwardImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            forwardImageView.topAnchor.constraint(equalTo: customBackgroundView.topAnchor, constant: 20),
            forwardImageView.bottomAnchor.constraint(equalTo: customBackgroundView.bottomAnchor, constant: -20),
            forwardImageView.trailingAnchor.constraint(equalTo: customBackgroundView.trailingAnchor, constant: -10),
            forwardImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            guard let user = user else { return }
            parentVC.showSearchResultTVC(for: user)
        }
    }
    
}
