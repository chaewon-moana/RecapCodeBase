//
//  MainTabBarViewController.swift
//  RecapCodeBase
//
//  Created by cho on 1/29/24.
//

import UIKit
protocol CodeBase {
    func setAddView()
    func configureAttribute()
    func configureLayout()
}

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tabbar = UITabBarController()
        
        let mainVC = UINavigationController(rootViewController: MainViewController())
        let profileVC = UINavigationController(rootViewController: SettingViewController())
        
        mainVC.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        profileVC.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person"), tag: 1)
        
        tabBar.barTintColor = .customPointColor
        //tabBar.tintColor = .customPointColor
        tabBar.tintColor = .white
        viewControllers = [mainVC, profileVC]
        
    }
}
