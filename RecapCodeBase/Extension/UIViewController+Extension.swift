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
    
    func showAlertWithOk(title: String, message: String) {
        let alert = UIAlertController(title: "닉네임 조건에 맞지 않습니다.", message: "닉네임을 조건에 맞게 다시 설정해주세요", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
  
}
