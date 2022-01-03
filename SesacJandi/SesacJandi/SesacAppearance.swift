//
//  SesacAppearance.swift
//  SesacJandi
//
//  Created by meng on 2022/01/04.
//


import UIKit

final class SesacAppearance {
    
    static func setupAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .label
        UINavigationBar.appearance().barTintColor = .label
    }
}
