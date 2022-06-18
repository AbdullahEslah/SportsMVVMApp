//
//  SearchBar.swift
//  SportsApp
//
//  Created by Macbook on 18/06/2022.
//

import Foundation
import UIKit

class SearchBar : NSObject, SearchBarProtocol {
    
    func configureSearchBar(navigationItem: UINavigationItem, searchBar: UISearchBar) {
        
        searchBar.placeholder = "Sports Search..."
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .white
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.titleView = searchBar
        
        // accessing childView - textField inside of the searchBar
        let searchBar_textField = searchBar.value(forKey: "searchField") as? UITextField
        searchBar_textField?.textColor = .label
        searchBar_textField?.tintColor = .white
    
        // insert searchBar into navigationBar
        navigationItem.titleView = searchBar
    }
    
    
}
