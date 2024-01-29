//
//  UIViewController+Extension.swift
//  RecapProject
//
//  Created by cho on 1/18/24.
//

import UIKit

extension UIViewController {
    
    func setCommonUI() {
        view.backgroundColor = .customBackgroundColor
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .customPointColor
    }
    
  
}
