//
//  SeSACButton.swift
//  RecapCodeBase
//
//  Created by cho on 1/29/24.
//

import UIKit
import SnapKit

class SeSACButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        setTitleColor(.customTextColor, for: .normal)
        backgroundColor = .customPointColor
        layer.cornerRadius = 8
        titleLabel?.font = .buttonTitleFont
        isUserInteractionEnabled = true
        
        
        snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
