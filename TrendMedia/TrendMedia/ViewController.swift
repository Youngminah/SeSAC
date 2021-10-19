//
//  ViewController.swift
//  TrendMedia
//
//  Created by meng on 2021/10/19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        self.title = "TREND MEDIA"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(menuBarButtonTap))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBarButtonTap))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    @objc private func menuBarButtonTap() {
        print("메뉴바")
    }
    
    @objc private func searchBarButtonTap() {
        print("서치바")
    }
}

