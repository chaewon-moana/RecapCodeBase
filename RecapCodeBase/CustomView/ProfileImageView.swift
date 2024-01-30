//
//  ProfileImageView.swift
//  RecapCodeBase
//
//  Created by cho on 1/29/24.
//

import UIKit
import SnapKit

class ProfileImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
    
    func configureView() {
        contentMode = .scaleAspectFit
//        let spacing: CGFloat = 16
//        let cellWidth = UIScreen.main.bounds.width - spacing * 5
//        //layer.cornerRadius = cellWidth / 4
//        //layer.borderWidth = size == 75 ? 4 : 6
        clipsToBounds = true
        layer.borderColor = UIColor.customPointColor.cgColor
        layer.borderWidth = 4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
