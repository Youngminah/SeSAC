//
//  ViewController.swift
//  newlyCoinedWord
//
//  Created by meng on 2021/10/04.
//

import UIKit

enum InputError: Error {
    case empty
    case notFound
}

class ViewController: UIViewController {
    
    private lazy var viewModel = WordViewModel()
    private lazy var searchHistoryInfo = SearchHistoryInfo()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let wordLabel: UILabel = {
        let label = UILabel()
        label.text = "연애를 시작하기 전 썸 단계!"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var userTextField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.borderWidth = .nan
        field.text = "삼귀자"
        field.font = .systemFont(ofSize: 13)
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.bounds.size.width = view.bounds.width
        return field
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.bounds.size.width = 40
        return button
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 0
        return view
    }()
    
    private let firstTagButton = UITagButton()
    private let secondTagButton = UITagButton()
    private let thirdTagButton = UITagButton()
    private let forthTagButton = UITagButton()
    private lazy var tagButtons = [firstTagButton, secondTagButton, thirdTagButton, forthTagButton]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setLayoutView()
    }
    
    @objc private func searchButtonTapped() {
        guard let target = self.userTextField.text, target != "" else {
            self.showAlert(error: .empty)
            return
        }
        guard let meaning = self.viewModel.searchWordMeaning(at: target) else {
            self.showAlert(error: .notFound)
            return
        }
        self.wordLabel.text = meaning
        let list = self.searchHistoryInfo.setWordList(with: target)
        self.setTagButtonTitle(at: list)
    }
}

//MARK: UI 업데이트에 관련된 함수
extension ViewController {
    
    private func setView(){
        view.addSubview(backgroundImageView)
        view.addSubview(wordLabel)
        view.addSubview(searchButton)
        view.addSubview(stackView)
        view.addSubview(firstTagButton)
        view.addSubview(secondTagButton)
        view.addSubview(thirdTagButton)
        view.addSubview(forthTagButton)
        self.setTagButtonTitle(at: self.searchHistoryInfo.wordList)
    }
    
    private func setLayoutView(){
        let size = view.bounds
        self.backgroundImageView.frame = view.bounds
        self.wordLabel.frame = CGRect(x: 32,
                                      y: (size.height/2) - 50,
                                      width: size.width - 64,
                                      height: 100)
        self.searchButton.frame = CGRect(x: 16,
                                         y: (size.height/2) - 10,
                                         width: 20,
                                         height: 20)
        self.setUpperStackView()
        self.firstTagButton.frame = CGRect(x: 16,
                                           y: self.stackView.bottom + 10,
                                           width: self.firstTagButton.width + 10,
                                           height: self.firstTagButton.height )
        self.secondTagButton.frame = CGRect(x: self.firstTagButton.right + 5,
                                           y: self.stackView.bottom + 10,
                                           width: self.secondTagButton.width + 10,
                                           height: self.secondTagButton.height )
        self.thirdTagButton.frame = CGRect(x: self.secondTagButton.right + 5,
                                           y: self.stackView.bottom + 10,
                                           width: self.thirdTagButton.width + 10,
                                           height: self.thirdTagButton.height )
        self.forthTagButton.frame = CGRect(x: self.thirdTagButton.right + 5,
                                           y: self.stackView.bottom + 10,
                                           width: self.forthTagButton.width + 10,
                                           height: self.forthTagButton.height )
    }
    
    //스택뷰 생성
    private func setUpperStackView(){
        stackView.addArrangedSubview(userTextField)
        stackView.addArrangedSubview(searchButton)
        self.stackView.frame = CGRect(x: 16,
                                      y: view.safeAreaInsets.top + 10,
                                      width: view.bounds.width - 32,
                                      height: 50)
    }
    
    //탭 버튼 업데이트
    private func setTagButtonTitle(at list: [String]){
        zip(tagButtons, list).forEach{ $0.setTitle($1, for: .normal) }
    }
}

//MARK: Alert에 관련된 함수
extension ViewController {
    private func showAlert(error: InputError){
        let ok = UIAlertAction(title: "OK", style: .default)
        let alert: UIAlertController
        switch error {
        case .empty:
            alert = UIAlertController(title: "단어를 입력하세요", message: .none, preferredStyle: .alert)
        case .notFound:
            alert = UIAlertController(title: "단어를 찾을 수 없습니다.", message: .none, preferredStyle: .alert)
        }
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}
