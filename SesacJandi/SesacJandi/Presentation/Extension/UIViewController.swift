//
//  UIViewController+Extension.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit

extension UIViewController {

    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = self.view.window {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
}
