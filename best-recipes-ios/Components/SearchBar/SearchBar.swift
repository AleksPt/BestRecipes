//
//  SearchBar.swift
//  best-recipes-ios
//
//  Created by Елена Логинова on 11.07.2024.
//

import UIKit

final class SearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchBar()
        setupSearchTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSearchBar() {
        setImage(Icons.search, for: .search, state: .normal)
        setPositionAdjustment(UIOffset(horizontal: 16, vertical: 0), for: .search)
        searchTextPositionAdjustment = UIOffset(horizontal: 11, vertical: 0)
        searchBarStyle = .default
        tintColor = UIColor.Colors.Neutral.neutral100
    }
    
    func setupSearchTextField() {
        searchTextField.backgroundColor = UIColor.white
        searchTextField.textColor = UIColor.black
        searchTextField.borderStyle = .none
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search recipes",
            attributes: [.font: UIFont.PoppinsFont.regular(size: 14),
                         .foregroundColor:UIColor.Colors.Neutral.neutral30])
        searchTextField.layer.masksToBounds = true
        searchTextField.layer.borderColor = UIColor.Colors.Neutral.neutral20.cgColor
        searchTextField.layer.borderWidth = 1.0
        searchTextField.layer.cornerRadius = 12.0
    }
}

