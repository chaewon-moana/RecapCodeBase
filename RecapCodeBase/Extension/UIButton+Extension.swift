//
//  UIButton+Extension.swift
//  RecapProject
//
//  Created by cho on 1/18/24.
//

import UIKit

extension UIButton {
    
    func customButton(text: String) {
        setTitle(text, for: .normal)
        setTitleColor(.customTextColor, for: .normal)
        backgroundColor = .customPointColor
        layer.cornerRadius = 8
        titleLabel?.font = .buttonTitleFont
        
    }
    
    func setfilteredButton() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
    }
    
}
