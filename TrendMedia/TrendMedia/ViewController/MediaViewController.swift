//
//  ViewController.swift
//  TrendMedia
//
//  Created by meng on 2021/10/19.
//

import UIKit
import SnapKit

class MediaViewController: UIViewController {

    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let categoryStackView: UIStackView = {
        let view = UIStackView()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 5.0
        view.backgroundColor = .white
        view.axis = .horizontal
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGreen
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavigationBar()
        addView()
    }
    
    @objc private func menuBarButtonTap() {
        print("메뉴바")
    }
    
    @objc private func searchBarButtonTap() {
        print("서치바")
    }
    
    private func setNavigationBar() {
        self.title = "TREND MEDIA"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(menuBarButtonTap))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBarButtonTap))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    private func addView() {
        view.addSubview(headerView)
        headerView.addSubview(categoryStackView)
        view.addSubview(tableView)
        setConstraints()
    }
    
    private func setConstraints() {
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaInsets.left)
            make.right.equalTo(view.safeAreaInsets.right)
            make.height.equalTo(view.bounds.height / 5)
        }
        
        categoryStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.equalTo(view.safeAreaInsets.left)
            make.right.equalTo(view.safeAreaInsets.right)
            make.bottom.equalTo(view.safeAreaInsets.bottom)
        }
    }
}

