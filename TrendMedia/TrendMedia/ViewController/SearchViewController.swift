//
//  SearchViewController.swift
//  TrendMedia
//
//  Created by meng on 2021/10/19.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let searchView = UIView()
    
    private let closeSceneButton: UIButton = {
        let button = UIButton()
        return button
    }()

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
    }
}
