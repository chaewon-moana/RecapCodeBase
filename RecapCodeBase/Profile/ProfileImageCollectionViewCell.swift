//
//  ProfileImageCollectionViewCell.swift
//  RecapProject
//
//  Created by cho on 1/18/24.
//

import UIKit
import SnapKit

class ProfileImageCollectionViewCell: UICollectionViewCell, CodeBase {
    
    let imageView = ProfileImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAddView()
        configureAttribute()
        configureLayout()
    }
    
    func setAddView() {
        contentView.addSubview(imageView)
    }
    
    func configureAttribute() {
        imageView.layer.borderWidth = 4
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
