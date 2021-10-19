//
//  ActorCell.swift
//  TrendMedia
//
//  Created by meng on 2021/10/19.
//

import UIKit

class ActorCell: UITableViewCell {
    
    static let identifier = "ActorCell"
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "스네이프")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "앨럭 릭먼"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let roleNameLabel: UILabel = {
        let label = UILabel()
        label.text = "스네이프 교수"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, roleNameLabel])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillProportionally
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setConstraint()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setConstraint() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(stackView)
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.left.equalTo(contentView.safeAreaInsets.left).offset(16)
            make.bottom.equalTo(contentView.safeAreaInsets.bottom).offset(-10)
            make.width.equalTo(profileImageView.snp.height)
        }
        
        stackView.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(16)
            make.right.equalTo(contentView.safeAreaInsets.right).offset(-16)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
    }
}
