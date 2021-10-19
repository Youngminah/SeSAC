//
//  SearchCell.swift
//  TrendMedia
//
//  Created by meng on 2021/10/19.
//

import UIKit
import SnapKit

class SearchCell: UITableViewCell {

    static let identifier = "SearchCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "squid_game")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Test Title"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "0000-00-00"
        label.textColor = .white
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private let previewContentLabel: UILabel = {
        let label = UILabel()
        label.text = "테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.backgroundColor = .clear
        setConstraint()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setConstraint() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoLabel)
        contentView.addSubview(previewContentLabel)
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.left.equalTo(contentView.safeAreaInsets.left).offset(16)
            make.bottom.equalTo(contentView.safeAreaInsets.bottom).offset(-16)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.7)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.left.equalTo(posterImageView.snp.right).offset(16)
            make.right.equalTo(contentView.safeAreaInsets.right).offset(-16)
            make.height.equalTo(25)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(1)
            make.left.equalTo(posterImageView.snp.right).offset(16)
            make.right.equalTo(contentView.safeAreaInsets.right).offset(-16)
            make.height.equalTo(20)
        }
        
        previewContentLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom)
            make.left.equalTo(posterImageView.snp.right).offset(16)
            make.right.equalTo(contentView.safeAreaInsets.right).offset(-16)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-16)
        }
    }
}
