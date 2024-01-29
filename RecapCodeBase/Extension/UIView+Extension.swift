//
//  UIView+Extension.swift
//  RecapProject
//
//  Created by cho on 1/18/24.
//

import UIKit

extension UIView {

    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
//    func setImageViewButton(size: Double) {
//        layer.cornerRadius = size / 2
//        layer.borderWidth = size == 75 ? 4 : 6
//        layer.borderColor = UIColor.customPointColor.cgColor
//    }
}