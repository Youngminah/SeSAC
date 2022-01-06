//
//  UIViewController+Extension.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit
import Toast

extension UIViewController {
    
    typealias AlertActionHandler = ((UIAlertAction) -> Void)
    
    func makeToastStyle() {
        var style = ToastStyle()
        style.messageFont = .systemFont(ofSize: 15)
        style.messageColor = .white
        style.backgroundColor = .label
        ToastManager.shared.style = style
    }
    
    func confirmAlert(title: String,
                     message: String? = nil,
                     okTitle: String = "확인",
                     okHandler: AlertActionHandler? = nil) -> UIAlertController {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: okTitle, style: .default, handler: okHandler)
        alert.addAction(okAction)
        return alert
    }
    
    func questionAlert(title: String,
                     message: String? = nil,
                     okTitle: String = "확인",
                     okStyle: UIAlertAction.Style = .destructive,
                     okHandler: AlertActionHandler? = nil,
                     cancelTitle: String? = "취소") -> UIAlertController {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: .default, handler: nil)
        alert.addAction(cancelAction)
        let okAction: UIAlertAction = UIAlertAction(title: okTitle, style: okStyle, handler: okHandler)
        alert.addAction(okAction)
        return alert
    }

    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = self.view.window {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    
    func changeHomeViewController() {
        let vc = HomeViewController()
        let navigationVC = HomeNavigationController(rootViewController: vc)
        changeRootViewController(navigationVC)
    }
    
    func changeIntroViewController() {
        let vc = IntroViewController()
        let navigationVC = UINavigationController(rootViewController: vc)
        changeRootViewController(navigationVC)
    }
}
