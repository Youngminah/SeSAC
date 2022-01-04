//
//  ComposeViewController.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit

class ComposeViewController: UIViewController {
    
    private let contentTextView = ContentTextView()
    
    private lazy var dismissBarButton = UIBarButtonItem(barButtonSystemItem: .close,
                                                   target: self,
                                                   action: #selector(dismissBarButtonTap))
    private lazy var completedBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                                     target: self,
                                                     action: #selector(completedBarButtonTap))

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        setConfiguration()
    }
    
    private func setView() {
        navigationItem.leftBarButtonItem = dismissBarButton
        navigationItem.rightBarButtonItem = completedBarButton
        view.addSubview(contentTextView)
    }
    
    private func setConstraints() {
        contentTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setConfiguration() {
        view.backgroundColor = .systemBackground
        contentTextView.becomeFirstResponder()
    }
    
    @objc
    private func dismissBarButtonTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func completedBarButtonTap() {
        
    }
}
