//
//  NavigationController.swift
//  TrendMedia
//
//  Created by meng on 2021/10/19.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setConfiguration()
    }
    private func setConfiguration(){
        self.navigationBar.scrollEdgeAppearance = UINavigationBarAppearance()
        self.navigationBar.scrollEdgeAppearance?.backgroundColor = .white
        
    }

}
