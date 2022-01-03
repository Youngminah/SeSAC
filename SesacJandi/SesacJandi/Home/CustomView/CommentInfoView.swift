//
//  CommentInfoView.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit

final class CommentInfoView: UIStackView {
    
    private let imageView = UIImageView(image: UIImage(systemName: "message"))
    private let label = UILabel()
    
    override init(frame: CGRect) { // 코드로 뷰가 생성될 때 생성자
        super.init(frame: frame)
        setView()
        setConfiguration()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView(){
        addArrangedSubview(imageView)
        addArrangedSubview(label)
    }
    
    private func setConfiguration(){
        axis = .horizontal
        spacing = 5
        imageView.tintColor = .label
        label.font = .systemFont(ofSize: 14)
        label.text = "댓글쓰기"
    }
    
    func setCommentCount(count: Int) {
        label.text = "댓글 \(count)"
    }
}
