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
        clipsToBounds = true
        layer.borderColor = UIColor.customPointColor.cgColor
        layer.borderWidth = 4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
