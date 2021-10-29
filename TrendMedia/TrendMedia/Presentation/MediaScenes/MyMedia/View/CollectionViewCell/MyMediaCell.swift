//
//  MyMediaCell.swift
//  TrendMedia
//
//  Created by meng on 2021/10/19.
//

import UIKit

class MyMediaCell: UICollectionViewCell {
    
    static let identifier = "MyMediaCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Test Title"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "squid_game")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0"
        label.textColor = .white
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .systemTeal
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        setConstraint()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraint() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(posterImageView)
        contentView.addSubview(rateLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.left.equalTo(contentView.safeAreaInsets.left).offset(16)
            make.right.equalTo(contentView.safeAreaInsets.right).offset(-16)
            make.height.equalTo(25)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.right.equalTo(contentView.safeAreaLayoutGuide).offset(-16)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide)
            make.width.equalTo(100)
        }
        
        rateLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView.safeAreaInsets.left).offset(16)
            make.bottom.equalTo(contentView.safeAreaInsets.right).offset(-16)
            make.right.equalTo(posterImageView.snp.left).offset(-16)
            make.height.equalTo(40)
        }
    }
}
