//
//  UIViewExtentions.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 01.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit.UIView

extension UIView {
    func pinToSuperview(_ view: UIView){
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
