//
//  BaseTableViewCell.swift
//  SesacJandi
//
//  Created by meng on 2022/01/04.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
        setConstraints()
        setConfiguration()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() { }
    func setConstraints() { }
    
    func setConfiguration() {
        contentView.isUserInteractionEnabled = false
        selectionStyle = .none
    }
}
