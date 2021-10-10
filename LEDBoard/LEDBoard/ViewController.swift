//
//  ViewController.swift
//  LEDBoard
//
//  Created by meng on 2021/10/04.
//

import UIKit

class ViewController: UIViewController {
    
    
    private lazy var upperContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var contentTextField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.cornerRadius = 12
        field.minimumFontSize = 8
        field.returnKeyType = .done
        field.font = .systemFont(ofSize: 11)
        field.placeholder = "텍스트를 입력해주세요"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("보내기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 11, weight: .regular)
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var colorChangeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Aa", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 11, weight: .regular)
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "정숙해주세요"
        label.textColor = UIColor(red: 0, green: 253, blue: 255, alpha: 1)
        label.backgroundColor = view.backgroundColor
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 300, weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        self.contentTextField.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let basic = view.bounds
        self.upperContainerView.frame = CGRect(x: 0,
                                               y: view.safeAreaInsets.top,
                                               width: basic.width,
                                               height: 60)
        self.contentTextField.frame = CGRect(x: 40,
                                             y: 10,
                                             width: upperContainerView.width - 80,
                                             height: 40)
        self.sendButton.frame = CGRect(x: contentTextField.right - 115,
                                       y: contentTextField.top + 6,
                                       width: 58 ,
                                       height: 28)
        self.colorChangeButton.frame = CGRect(x: contentTextField.right - 50,
                                              y: contentTextField.top + 6,
                                              width: 38,
                                              height: 28)
        self.contentLabel.frame = CGRect(x: 40,
                                         y: 0,
                                         width: basic.width - 80,
                                         height: basic.height)
    }
    
    @objc private func sendButtonTapped() {
        guard let message = contentTextField.text else { return }
        self.contentLabel.text = message
    }
    
    @objc private func changeColorButtonTapped() {
        let color = getRandomUIColor()
        self.contentLabel.textColor = color
    }
    
    @objc private func toggleUpperView() {
        self.upperContainerView.isHidden = !self.upperContainerView.isHidden
    }
    
    //키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
   }
}

//MARK: UI관련
extension ViewController{
    
    func updateUI(){
        self.view.backgroundColor = .black
        self.view.addSubview(contentLabel)
        self.view.addSubview(upperContainerView)
        self.upperContainerView.addSubview(contentTextField)
        self.upperContainerView.addSubview(sendButton)
        self.upperContainerView.addSubview(colorChangeButton)
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(self.toggleUpperView))
        //self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
        self.sendButton.addTarget(self,
                                  action: #selector(sendButtonTapped),
                                  for: .touchUpInside)
        self.colorChangeButton.addTarget(self,
                                         action: #selector(changeColorButtonTapped),
                                         for: .touchUpInside)
    }
    
    //랜덤컬러 리턴
    func getRandomUIColor() -> UIColor {
        let r : CGFloat = CGFloat.random(in: 0...1)
        let g : CGFloat = CGFloat.random(in: 0...1)
        let b : CGFloat = CGFloat.random(in: 0...1)
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}

extension ViewController: UITextFieldDelegate {
    //리턴 터치시 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        view.endEditing(true)
        return true
    }
}


