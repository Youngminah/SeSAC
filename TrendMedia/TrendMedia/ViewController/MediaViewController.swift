//
//  ViewController.swift
//  TrendMedia
//
//  Created by meng on 2021/10/19.
//

import UIKit
import SnapKit

class MediaViewController: UIViewController {
    
    
    private let viewModel = MediaViewModel()
    private let headerView = UIView()
    
    private let categoryStackView: UIStackView = {
        let view = UIStackView()
        view.setCornerShadow()
        view.backgroundColor = .white
        view.axis = .horizontal
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    @objc private func menuBarButtonTap() {
        self.navigationItem.backButtonTitle = "뒤로" //백버튼 설정은 이전화면에서 설정
        let vc = MyMediaViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func searchBarButtonTap() {
        let vc = SearchViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    private func setView() {
        view.backgroundColor = .white
        setNavigationBar()
        addView()
        setConstraints()
        setTableView()
    }
    
    private func setNavigationBar() {
        self.title = "TREND MEDIA"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(menuBarButtonTap))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                                 target: self,
                                                                 action: #selector(searchBarButtonTap))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MediaCell.self, forCellReuseIdentifier: MediaCell.identifier)
    }
    
    private func addView() {
        view.addSubview(headerView)
        headerView.addSubview(categoryStackView)
        view.addSubview(tableView)
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

extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tvShowListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaCell.identifier, for: indexPath) as? MediaCell else {
            return UITableViewCell()
        }
        cell.updateUI(media: viewModel.getTvShow(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationItem.backButtonTitle = "뒤로" //백버튼 설정은 이전화면에서 설정
        let vc = ActorViewController()
        vc.mediaInfo = viewModel.getTvShow(at: indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

