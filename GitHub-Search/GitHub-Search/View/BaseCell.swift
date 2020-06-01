//
//  BaseCell.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 31.05.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell{

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        SetupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func SetupViews(){
        
    }
    
}
