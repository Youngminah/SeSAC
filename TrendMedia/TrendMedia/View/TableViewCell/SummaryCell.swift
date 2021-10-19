//
//  SummaryCell.swift
//  TrendMedia
//
//  Created by meng on 2021/10/19.
//

import UIKit

class SummaryCell: UITableViewCell {
    
    static let identifier = "SummaryCell"
    
    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.text = "테테테 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트 테스트"
        label.textColor = .label
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    let detailToggleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.setImage(UIImage(systemName: "chevron.up"), for: .selected)
        button.tintColor = .label
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        //self.contentView.backgroundColor = .orange
        setConstraint()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraint() {
        contentView.addSubview(summaryLabel)
        contentView.addSubview(detailToggleButton)
        
        summaryLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.left.equalTo(contentView.safeAreaInsets.left).offset(16)
            make.right.equalTo(contentView.safeAreaInsets.right).offset(-16)
            make.bottom.equalTo(contentView.safeAreaInsets.bottom).offset(-30)
        }
        
        detailToggleButton.snp.makeConstraints { make in
            make.top.equalTo(summaryLabel.snp.bottom)
            make.left.equalTo(contentView.safeAreaInsets.left).offset(16)
            make.right.equalTo(contentView.safeAreaInsets.right).offset(-16)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
}
