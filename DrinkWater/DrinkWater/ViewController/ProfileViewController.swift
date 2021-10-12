//
//  ProfileViewController.swift
//  DrinkingWater
//
//  Created by meng on 2021/10/09.
//

import UIKit
import TextFieldEffects

enum InputError: Error {
    case emptyNickname
    case emptyHeight
    case emptyWeight
    case invalidHeight
    case invalidWeight
}

class ProfileViewController: UIViewController {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var containerBottom: NSLayoutConstraint!
    @IBOutlet private weak var plantImageView: UIImageView!
    @IBOutlet private weak var nickNameTextField: HoshiTextField!
    @IBOutlet private weak var heightTextField: HoshiTextField!
    @IBOutlet private weak var weightTextField: HoshiTextField!
    @IBOutlet private weak var stackView: UIStackView!
    
    var image = UIImage()
    private var nickName = String()
    private var heightText = String()
    private var weightText = String()
    var delegate: UserInfoDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAttributes()
        self.setTextField()
    }
    
    @objc private func saveButtonTap(_ sender: UIBarButtonItem){
        self.checkValidTextField()
    }
    
    private func checkValidTextField() {
        guard let nickName = nickNameTextField.text, nickName != "" else {
            self.showErrorAlert(error: .emptyNickname)
            return
        }
        guard let heightString = heightTextField.text, heightString != "" else {
            self.showErrorAlert(error: .emptyHeight)
            return
        }
        guard let weightString = weightTextField.text, weightString != "" else {
            self.showErrorAlert(error: .emptyWeight)
            return
        }
        guard let height = Int(heightString) else {
            self.showErrorAlert(error: .invalidHeight)
            return
        }
        guard let weight = Int(weightString) else {
            self.showErrorAlert(error: .invalidWeight)
            return
        }
        self.showCompleteAlert(nickName: nickName, height: height, weight: weight)
    }
}

//MARK: textField delegate
extension ProfileViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 { return true }
        }
        guard let text = textField.text else {return true}
        switch textField.tag {
        case 0:
            if text.count > 8 { return false }
        case 1:
            if text.count > 2 { return false }
        default:
            if text.count > 2 { return false }
        }
        return true
    }
}

//MARK: alert
extension ProfileViewController {
    private func showErrorAlert(error: InputError){
        let ok = UIAlertAction(title: "확인", style: .default)
        let alert: UIAlertController
        switch error {
        case .emptyNickname:
            alert = UIAlertController(title: "닉네임을 입력하세요", message: .none, preferredStyle: .alert)
        case .emptyHeight:
            alert = UIAlertController(title: "키를 입력하세요", message: .none, preferredStyle: .alert)
        case .emptyWeight:
            alert = UIAlertController(title: "몸무게를 입력하세요", message: .none, preferredStyle: .alert)
        case .invalidHeight:
            alert = UIAlertController(title: "키(cm)를 숫자로만 입력하세요", message: .none, preferredStyle: .alert)
        case .invalidWeight:
            alert = UIAlertController(title: "몸무게(kg)를 숫자로만 입력하세요", message: .none, preferredStyle: .alert)
        }
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    private func showCompleteAlert(nickName: String, height: Int, weight: Int){
        let ok = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.delegate?.setInfo(nickName: nickName, height: height, weight: weight)
            self?.navigationController?.popViewController(animated: true)
        }
        let alert: UIAlertController
        alert = UIAlertController(title: "저장되었습니다.", message: .none, preferredStyle: .alert)
        alert.addAction(ok)
        self.present(alert, animated: true) 
    }
}

//MARK: keyboard
extension ProfileViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
    }
    
    @objc private func adjustKeyboard(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if noti.name == UIResponder.keyboardWillShowNotification {
            let adjustmentHeight = keyboardFrame.height - (containerView.height - stackView.bottom)
            if adjustmentHeight > 0 {
                containerBottom.constant = adjustmentHeight + 20   //만약 키보드가 텍스트 필드를 가릴때만 뷰이동
            }
        } else {
            containerBottom.constant = 0
        }
    }
}

//MARK: set ui
extension ProfileViewController {
    
    func setText(nickName: String = "", heightText: String = "", weightText: String = ""){
        self.nickName = nickName
        self.heightText = heightText
        self.weightText = weightText
    }
    
    private func setTextField() {
        self.nickNameTextField.text = nickName
        self.heightTextField.text = heightText
        self.weightTextField.text = weightText
    }
    
    private func setAttributes(){
        self.view.backgroundColor = UIColor.accentColor
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTap))
        NotificationCenter.default.addObserver(self, selector: #selector(adjustKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.nickNameTextField.delegate = self
        self.heightTextField.delegate = self
        self.weightTextField.delegate = self

        self.nickNameTextField.tag = 0
        self.heightTextField.tag = 1
        self.weightTextField.tag = 2
        self.plantImageView.image = image
        self.nickNameTextField.textColor = .white
        self.nickNameTextField.placeholderColor = .white
        self.nickNameTextField.borderActiveColor = .white
        self.nickNameTextField.borderInactiveColor = .white
        self.nickNameTextField.borderStyle = .line
        self.nickNameTextField.placeholder = "닉네임을 설정해주세요"
        self.nickNameTextField.placeholderFontScale = 0.8
        self.nickNameTextField.textAlignment = .left
        self.nickNameTextField.autocapitalizationType = .none
        self.nickNameTextField.autocorrectionType = .no
        self.nickNameTextField.keyboardType = .namePhonePad
        
        self.heightTextField.textColor = .white
        self.heightTextField.placeholderColor = .white
        self.heightTextField.borderActiveColor = .white
        self.heightTextField.borderInactiveColor = .white
        self.heightTextField.borderStyle = .line
        self.heightTextField.placeholderFontScale = 0.8
        self.heightTextField.placeholder = "키(cm)를 설정해주세요"
        self.heightTextField.textAlignment = .left
        self.heightTextField.autocapitalizationType = .none
        self.heightTextField.autocorrectionType = .no
        self.heightTextField.keyboardType = .numberPad
        
        self.weightTextField.textColor = .white
        self.weightTextField.placeholderColor = .white
        self.weightTextField.borderActiveColor = .white
        self.weightTextField.borderInactiveColor = .white
        self.weightTextField.borderStyle = .line
        self.weightTextField.placeholder = "몸무게(kg)를 설정해주세요"
        self.weightTextField.placeholderFontScale = 0.8
        self.weightTextField.textAlignment = .left
        self.weightTextField.autocapitalizationType = .none
        self.weightTextField.autocorrectionType = .no
        self.weightTextField.keyboardType = .numberPad
    }
}
