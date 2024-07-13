//
//  SearchBar.swift
//  best-recipes-ios
//
//  Created by Елена Логинова on 11.07.2024.
//

import UIKit

final class SearchBar: UISearchBar, UISearchBarDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchBar()
        setupSearchTextField()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setShowsCancelButton(false, animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSearchBar() {
        setImage(Icons.search, for: .search, state: .normal)
        setImage(Icons.close, for: .clear, state: .normal)
        returnKeyType = UIReturnKeyType.default
        showsCancelButton = false
        setPositionAdjustment(UIOffset(horizontal: 16, vertical: 0), for: .search)
        searchTextPositionAdjustment = UIOffset(horizontal: 11, vertical: 0)
        searchBarStyle = .default
    }
    
    func setupSearchTextField() {
        searchTextField.backgroundColor = UIColor.white
        searchTextField.textColor = UIColor.Search.textField
        searchTextField.borderStyle = .none
        searchTextField.autocapitalizationType = .none
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search recipes",
            attributes: [.font: UIFont.TextFonts.Search.textfield,
                         .foregroundColor: UIColor.Search.placeholderField])
        searchTextField.layer.masksToBounds = true
        searchTextField.layer.borderColor = UIColor.Search.borderField.cgColor
        searchTextField.layer.borderWidth = 1.0
        searchTextField.layer.cornerRadius = 10.0
    }
}
