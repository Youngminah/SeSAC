//
//  MediaCell.swift
//  TrendMedia
//
//  Created by meng on 2021/10/19.
//

import UIKit
import SnapKit

class MediaCell: UITableViewCell {
    
    static let identifier = "MediaCell"
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.text = "#Test Category"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let enTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Test Title"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let mediaView: UIView = {
        let view = UIView()
        view.setCornerShadow()
        return view
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "squid_game")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let krTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "한국어 테스트"
        label.textColor = .black
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "0000-00-00"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.text = "3.2"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let label = UILabel()
        label.text = "예상"
        label.textColor = .black
        label.backgroundColor = .orange
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .regular)
        
        let stackView = UIStackView(arrangedSubviews: [label, rateLabel])
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillProportionally
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 8
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
        contentView.addSubview(genreLabel)
        contentView.addSubview(enTitleLabel)
        contentView.addSubview(mediaView)
        mediaView.addSubview(posterImageView)
        mediaView.addSubview(krTitleLabel)
        mediaView.addSubview(dateLabel)
        contentView.addSubview(stackView)
        
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.left.equalTo(contentView.safeAreaInsets.left).offset(20)
            make.right.equalTo(contentView.safeAreaInsets.right).offset(-20)
            make.height.equalTo(20)
        }
        
        enTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(5)
            make.left.equalTo(contentView.safeAreaInsets.left).offset(20)
            make.right.equalTo(contentView.safeAreaInsets.right).offset(-20)
            make.height.equalTo(25)
        }
        
        mediaView.snp.makeConstraints { make in
            make.top.equalTo(enTitleLabel.snp.bottom).offset(10)
            make.left.equalTo(contentView.safeAreaInsets.left).offset(20)
            make.right.equalTo(contentView.safeAreaInsets.right).offset(-20)
            make.bottom.equalTo(contentView.safeAreaInsets.bottom).offset(-20)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        
        krTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(25)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(krTitleLabel.snp.bottom).offset(1)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(mediaView.snp.leading).offset(20)
            make.bottom.equalTo(posterImageView.snp.bottom).offset(-20)
            make.height.equalTo(30)
            make.width.equalTo(60)
        }
    }
}
