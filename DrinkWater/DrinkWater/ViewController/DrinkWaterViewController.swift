//
//  ViewController.swift
//  DrinkingWater
//
//  Created by meng on 2021/10/09.
//

import UIKit

enum Done {
    case doneAddWater
    case doneRefresh
}

protocol UserInfoDelegate: AnyObject {
    func setInfo(nickName: String, height: Int, weight: Int)
}

class DrinkWaterViewController: UIViewController {
    @IBOutlet private weak var refreshBarButton: UIBarButtonItem!
    @IBOutlet private weak var profileBarButton: UIBarButtonItem!
    @IBOutlet private weak var infoPhraseLabel: UILabel!
    @IBOutlet private weak var infoIntakeLabel: UILabel!
    @IBOutlet private weak var infoGoalLabel: UILabel!
    @IBOutlet private weak var infoStackView: UIStackView!
    @IBOutlet private weak var plantImageView: UIImageView!
    @IBOutlet private weak var recommendIntakeLabel: UILabel!
    @IBOutlet private weak var drinkWaterButton: UIButton!
    @IBOutlet private weak var inputStackView: UIStackView!
    @IBOutlet private weak var mlTextField: UITextField!
    @IBOutlet private weak var mlLabel: UILabel!
    @IBOutlet private weak var noUserNotiLabel: UILabel!
    @IBOutlet private weak var plantImageViewCenter: NSLayoutConstraint!
    
    private let userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAttributes()
        self.setAllInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setImageViewAnimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.setImageViewIdentity()
    }

    @IBAction func profileButtonTap(_ sender: UIBarButtonItem) {
        self.moveToProfileScene()
    }
    
    @IBAction func drinkWaterButtonTap(_ sender: UIButton) {
        guard let mlString = mlTextField.text, mlString != "" , let ml = Int(mlString) else {
            self.showInvalidWaterAlert()
            return
        }
        self.infoPhraseLabel.text = "잘하셨어요!\n오늘 마신 양은"
        let accumulateWater = userViewModel.accumulateWater + ml
        self.userViewModel.updateAccumulateWater(ml: accumulateWater)
        self.setUserInfo()
        self.showDoneAlert(done: .doneAddWater)
    }
    
    @IBAction func refreshButtonTap(_ sender: UIBarButtonItem) {
        self.setInitialInfo()
        self.showDoneAlert(done: .doneRefresh)
    }
}

//MARK: custom protocol
extension DrinkWaterViewController: UserInfoDelegate{
    func setInfo(nickName: String, height: Int, weight: Int) {
        if userViewModel.isNoUser() {
            self.inputStackView.isHidden = false
            self.refreshBarButton.isEnabled = true
            self.infoStackView.isHidden = false
            self.noUserNotiLabel.isHidden = true
            self.drinkWaterButton.isEnabled = true
            self.drinkWaterButton.setTitle("물마시기", for: .normal)
            self.userViewModel.initialUserInfo(nickName: nickName, height: height, weight: weight)
        } else {
            self.userViewModel.updateUserInfo(nickName: nickName, height: height, weight: weight)
        }
        self.setUserInfo()
    }
}

//MARK: textField delegate
extension DrinkWaterViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 { return true }
        }
        guard let text = textField.text else {return true}
        if text.count > 3 { return false }
        return true
    }
}

//MARK: alert
extension DrinkWaterViewController {
    private func showDoneAlert(done: Done){
        let alert: UIAlertController
        switch done {
        case .doneAddWater:
            let ok = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
                self?.mlTextField.text = .none
            }
            alert = UIAlertController(title: "물 마시기에 성공하였습니다", message: .none, preferredStyle: .alert)
            alert.addAction(ok)
        case .doneRefresh:
            let ok = UIAlertAction(title: "확인", style: .default)
            alert = UIAlertController(title: "초기화 되었습니다", message: .none, preferredStyle: .alert)
            alert.addAction(ok)
        }
        self.present(alert, animated: true)
    }
    
    private func showInvalidWaterAlert(){
        let ok = UIAlertAction(title: "확인", style: .default)
        let alert = UIAlertController(title: "물의 양(ml)을 정확히 입력해 주세요", message: .none, preferredStyle: .alert)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}

//MARK: set ui
extension DrinkWaterViewController{
    private func setAllInfo(){
        self.userViewModel.isNoUser() ? self.setNoUserInfo() : self.setUserInfo()
    }
    
    private func setInitialInfo(){
        self.infoPhraseLabel.text = userViewModel.phraseText
        self.userViewModel.updateAccumulateWater(ml: 0)
        self.infoGoalLabel.text = "목표의 0%"
        self.plantImageView.image = UIImage(named: "1-1")
        self.infoIntakeLabel.text = "0ml"
        self.recommendIntakeLabel.text = userViewModel.recommendIntakeText
        self.infoPhraseLabel.textColor = .white
    }
    
    private func setNoUserInfo(){
        self.inputStackView.isHidden = true
        self.refreshBarButton.isEnabled = false
        self.infoStackView.isHidden = true
        self.noUserNotiLabel.isHidden = false
        self.noUserNotiLabel.text = "새로 오셨군요! 시작하기 👆🏻"
        self.plantImageView.image = UIImage(named: "1-1")
        self.recommendIntakeLabel.text = userViewModel.recommendIntakeText
        self.drinkWaterButton.isEnabled = false
        self.drinkWaterButton.setTitle("등록된 유저가 없어요", for: .disabled)
    }
    
    private func setUserInfo(){
        self.noUserNotiLabel.isHidden = true
        self.infoIntakeLabel.text = userViewModel.intakeText
        self.recommendIntakeLabel.text = userViewModel.recommendIntakeText
        self.plantImageView.setPlantImage(at: userViewModel.percentGoal)
        self.infoGoalLabel.text = userViewModel.percentGoalText
        self.infoPhraseLabel.text = userViewModel.phraseText
        self.infoPhraseLabel.textColor = userViewModel.phraseColor
    }
    
    private func setAttributes(){
        self.view.backgroundColor = UIColor.accentColor
        self.setNavigationArea()
        self.setUpperArea()
        self.setMiddleArea()
        self.setBottomArea()
    }
    
    private func setNavigationArea(){
        self.title = "물 마시기"
        self.profileBarButton.image = UIImage(systemName: "person.circle")
        self.profileBarButton.title = .none
        self.refreshBarButton.title = .none
        self.refreshBarButton.image = UIImage(systemName: "arrow.clockwise")
    }
    
    private func setUpperArea(){
        self.infoPhraseLabel.text = "시작해볼까요?\n오늘 마신 양은"
        self.infoPhraseLabel.numberOfLines = 2
        self.infoPhraseLabel.textColor = .white
        self.infoPhraseLabel.font = .systemFont(ofSize: 23, weight: .medium)
        self.infoPhraseLabel.adjustsFontSizeToFitWidth = true
        self.infoIntakeLabel.textColor = .white
        self.infoIntakeLabel.sizeToFit()
        self.infoIntakeLabel.font = .systemFont(ofSize: 27, weight: .bold)
        self.infoIntakeLabel.adjustsFontSizeToFitWidth = true
        self.infoGoalLabel.textColor = .white
        self.infoGoalLabel.sizeToFit()
        self.infoGoalLabel.font = .systemFont(ofSize: 14, weight: .light)
        self.infoGoalLabel.adjustsFontSizeToFitWidth = true
        self.noUserNotiLabel.textColor = .white
        self.noUserNotiLabel.font = .systemFont(ofSize: 16, weight: .bold)
        self.noUserNotiLabel.adjustsFontSizeToFitWidth = true
        self.noUserNotiLabel.textAlignment = .right
        self.noUserNotiLabel.numberOfLines = 2
    }
    
    private func setMiddleArea(){
        NotificationCenter.default.addObserver(self, selector: #selector(adjustKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.inputStackView.spacing = 2
        self.mlLabel.text = "ml"
        self.mlLabel.textColor = .white
        self.mlLabel.font = .systemFont(ofSize: 25, weight: .regular)
        self.mlLabel.textAlignment = .left
        self.mlTextField.delegate = self
        self.mlTextField.placeholder = "300"
        self.mlTextField.textColor = .white
        self.mlTextField.textAlignment = .right
        self.mlTextField.font = .systemFont(ofSize: 25, weight: .regular)
        self.mlTextField.adjustsFontSizeToFitWidth = true
        self.mlTextField.keyboardType = .numberPad
    }
    
    private func setBottomArea(){
        self.recommendIntakeLabel.textColor = .white
        self.recommendIntakeLabel.textAlignment = .center
        self.recommendIntakeLabel.font = .systemFont(ofSize: 14, weight: .regular)
        self.drinkWaterButton.backgroundColor = .white
        self.drinkWaterButton.tintColor = .label
        self.drinkWaterButton.setTitle("물마시기", for: .normal)
    }
    
    private func moveToProfileScene(){
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileScene") as? ProfileViewController else{ return }
        vc.delegate = self
        vc.image = plantImageView.image!
        userViewModel.isNoUser() ? vc.setText() : vc.setText(nickName: userViewModel.nickName, heightText: "\(userViewModel.height)", weightText: "\(userViewModel.weight)")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: animation
extension DrinkWaterViewController {
    private func setImageViewAnimation(){
        UIView.animate(withDuration: 1.2, delay: 0, options: [.repeat, .autoreverse, .beginFromCurrentState]) {
            self.plantImageView.transform = CGAffineTransform(translationX: 0, y: 0).scaledBy(x: 0.9, y: 0.9)
        }
    }
    
    private func setImageViewIdentity(){
        self.plantImageView.layer.removeAllAnimations()
        self.plantImageView.transform = .identity
    }
}

//MARK: keyboard
extension DrinkWaterViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
    }
    
    @objc
    private func adjustKeyboard(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if noti.name == UIResponder.keyboardWillShowNotification {
            let adjustmentHeight = keyboardFrame.height - (view.height - inputStackView.bottom)
            if adjustmentHeight > 0 {
                plantImageViewCenter.constant = -adjustmentHeight - 50 //만약 키보드가 텍스트 필드를 가릴때만 뷰 이동
            }
        } else {
            plantImageViewCenter.constant = -50
        }
    }
}
