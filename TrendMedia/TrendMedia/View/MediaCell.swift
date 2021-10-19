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
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "상어상어"
        label.textColor = UIColor.gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraint()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraint() {
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.left.equalTo(contentView.safeAreaInsets.left)
            make.right.equalTo(contentView.safeAreaInsets.right)
            make.bottom.equalTo(contentView.safeAreaInsets.bottom)        }
    }
}
