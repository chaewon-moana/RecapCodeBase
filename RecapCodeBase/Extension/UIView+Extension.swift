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
}
