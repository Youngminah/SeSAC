//
//  ActorCell.swift
//  TrendMedia
//
//  Created by meng on 2021/10/19.
//

import UIKit

class ActorCell: UITableViewCell {
    
    static let identifier = "ActorCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        //setConstraint()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
