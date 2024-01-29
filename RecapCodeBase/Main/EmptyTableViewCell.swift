//
//  EmptyTableViewCell.swift
//  RecapProject
//
//  Created by cho on 1/19/24.
//

import UIKit
import SnapKit

class EmptyTableViewCell: UITableViewCell, CodeBase {
    
    let emptyImage = UIImageView()
    let emptyLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAddView()
        configureLayout()
        configureAttribute()
        isUserInteractionEnabled = false
        
    }

    func setAddView() {
        contentView.addSubview(emptyImage)
        contentView.addSubview(emptyLabel)
    }
    
    func configureAttribute() {
        
        emptyImage.image = .empty
        emptyImage.contentMode = .scaleAspectFit
        
        emptyLabel.text = "최근 검색어가 없어요"
        emptyLabel.font = .boldHeaderFont
        emptyLabel.textAlignment = .center
    }
    
    func configureLayout() {
        emptyImage.snp.makeConstraints { make in
            make.size.equalTo(300)
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(50)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(24)
            make.top.equalTo(emptyImage.snp.bottom).offset(-30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
