//
//  MainNavigationController.swift
//  DrinkingWater
//
//  Created by meng on 2021/10/10.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConfiguration()
    }
    
    private func setConfiguration(){
        self.navigationBar.scrollEdgeAppearance = UINavigationBarAppearance()
        self.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor.accentColor
    }
}
