//
//  ActorViewController.swift
//  TrendMedia
//
//  Created by meng on 2021/10/19.
//

import UIKit

class ActorViewController: UIViewController {
    
    var mediaInfo: TvShow?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 90, bottom: 0, right: 16)
        return tableView
    }()
    
    private lazy var tableHeaderView: UIView = {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 200))
        return header
    }()
    
    private let posterImageView = UIImageView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "테스트"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        posterImageView.image = UIImage(named: "paw_pastrol")
        posterImageView.clipsToBounds = true
        posterImageView.contentMode = .scaleAspectFill
        addView()
        setConstraints()
        setConfiguration()
    }
    
    func updateUI(){
        guard let media = mediaInfo else { return }
        titleLabel.text = media.title
        setImageView(urlString: media.backdropImage)
    }
    
    private func setImageView(urlString: String){
        let url = URL(string: urlString)
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(with: url, placeholder: UIImage(named: "덤블도어")) //이미지 없을시 이미지 넣기
    }
    
    private func setConfiguration() {
        self.view.backgroundColor = .white
        self.title = "출연/제작"
        self.navigationController?.navigationBar.tintColor = .label
        updateUI()
        setTableView()
    }
    
    private func addView() {
        view.addSubview(tableView)
        tableHeaderView.addSubview(posterImageView)
        tableHeaderView.addSubview(titleLabel)
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaInsets.left)
            make.right.equalTo(view.safeAreaInsets.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ActorCell.self, forCellReuseIdentifier: ActorCell.identifier)
        tableView.tableHeaderView = tableHeaderView
    }
}

extension ActorViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ActorCell.identifier, for: indexPath) as? ActorCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

