//
//  UISearchBarExtensions.swift
//  GitHub-Search
//
//  Created by Ali Bahadori on 07.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit.UISearchBar

extension UISearchBar {
    public var textField: UITextField {
        if #available(iOS 13.0, *) {
            return searchTextField
        }

        guard let firstSubview = subviews.first else {
            fatalError("Could not find text field")
        }

        for view in firstSubview.subviews {
            if let textView = view as? UITextField {
                return textView
            }
        }

       fatalError("Could not find text field")
    }
}
