//
//  ViewController.swift
//  AnniversaryCalculator
//
//  Created by meng on 2021/10/07.
//

import UIKit

class ViewController: UIViewController {

    private let datePicker = UIDatePicker()
    private var collectionView: UICollectionView!
    private lazy var userTapDate = Date() {
        didSet{ collectionView.reloadData() }  //변수안의 날짜 변하면 컬렉션뷰 리로드
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAttributes()
        self.addView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setContraints()
    }
    
    @objc
    private func handleDatePicker(_ sender: UIDatePicker) {
        self.userTapDate = sender.date
    }
    
    private func setCollectionView(){
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .white
        self.collectionView.register(AnniversaryCell.self, forCellWithReuseIdentifier: "AnniversaryCell")
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.isScrollEnabled = false
    }
    
    private func setAttributes(){
        view.backgroundColor = .white
        self.setCollectionView()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.tintColor = .orange
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.backgroundColor = .white
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
    }
    
    private func addView(){
        view.addSubview(datePicker)
        view.addSubview(collectionView)
    }
    
    private func setContraints(){
        let size = view.bounds
        datePicker.frame = CGRect(x: 16 ,
                                  y: view.safeAreaInsets.top,
                                  width: size.width - 32 ,
                                  height: (size.width/7) * 6 )
        collectionView.frame = CGRect(x: 16,
                                      y: datePicker.bottom + 16,
                                      width: size.width - 32,
                                      height: size.height - datePicker.bottom - view.safeAreaInsets.bottom - 16)
        
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnniversaryCell", for: indexPath) as? AnniversaryCell else {
            return UICollectionViewCell()
        }
        cell.updateUI(at: indexPath.item, at: userTapDate)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.bounds.width - 16)/2
        let height: CGFloat = (view.height - datePicker.bottom - view.safeAreaInsets.bottom - 32)/2
        return CGSize(width: width, height: height)
    }
}
