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
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        return button
    }()

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.clipsToBounds = true
        searchBar.layer.cornerRadius = 10
        searchBar.tintColor = .white
        searchBar.barTintColor = .gray
        searchBar.searchTextField.backgroundColor = .gray
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.searchSceneBackgroundColor
        addView()
        setConstraints()
        setConfiguration()
    }
    
    @objc private func closeButtonTap(){
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setConfiguration() {
        closeSceneButton.addTarget(self, action: #selector(closeButtonTap), for: .touchUpInside)
        setTableView()
    }
    
    private func addView() {
        view.addSubview(searchView)
        searchView.addSubview(closeSceneButton)
        searchView.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaInsets.left)
            make.right.equalTo(view.safeAreaInsets.right)
            make.height.equalTo(60)
        }
        
        closeSceneButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        searchBar.snp.makeConstraints { make in
            make.left.equalTo(closeSceneButton.snp.right).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom)
            make.left.equalTo(view.safeAreaInsets.left)
            make.right.equalTo(view.safeAreaInsets.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
