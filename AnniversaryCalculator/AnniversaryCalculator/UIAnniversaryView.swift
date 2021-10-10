//
//  DDayView.swift
//  AnniversaryCalculator
//
//  Created by meng on 2021/10/07.
//

import UIKit

class UIAnniversaryView: UIView {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "마카롱1")
        view.contentMode = .scaleToFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30
        view.alpha = 0.7
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        return label
    }()
    
    private let calculateDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) { // 코드로 뷰가 생성될 때 생성자
        super.init(frame: frame)
        self.setContraints()
    }
    
    required init?(coder: NSCoder) { //스토리보드로 뷰가 생성될 때 생성자
        super.init(coder: coder)
    }
    
    func setTitle(date: String, calculateDate: String, imageTitle: String){
        imageView.image = UIImage(named: imageTitle)
        dateLabel.text = date
        calculateDateLabel.text = calculateDate
    }
    
    private func setContraints(){
        backgroundColor = .black
        layer.cornerRadius = 30
        addSubview(imageView)
        addSubview(dateLabel)
        addSubview(calculateDateLabel)
        //이부분 왜안되는거지..?
//        imageView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
//        dateLabel.frame = CGRect(x: 10, y: 10, width: self.width - 20, height: self.height/6)
//        calculateDateLabel.frame = CGRect(x: 0, y: 0, width: self.width , height: self.height)
        
        //위에 대체코드 -_-
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
            
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            dateLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: 16),
            
            calculateDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            calculateDateLabel.topAnchor.constraint(equalTo: topAnchor),
            calculateDateLabel.widthAnchor.constraint(equalTo: widthAnchor),
            calculateDateLabel.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}
