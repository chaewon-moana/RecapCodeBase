//
//  RecentSearchesTableViewCell.swift
//  RecapProject
//
//  Created by cho on 1/18/24.
//

import UIKit
import SnapKit

class RecentSearchesTableViewCell: UITableViewCell, CodeBase {
    
    let searchImageView = UIImageView()
    let searchesLabel = UILabel()
    let deleteButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setAddView()
        configureLayout()
        configureAttribute()
    }

    func setAddView() {
        contentView.addSubview(searchImageView)
        contentView.addSubview(searchesLabel)
        contentView.addSubview(deleteButton)
    }
    
    func configureAttribute() {
        searchImageView.image = UIImage(systemName: "magnifyingglass")
        searchImageView.tintColor = .white
        
        searchesLabel.font = .smallBodyFont
        searchesLabel.textColor = .lightGray
        
        deleteButton.setImage(UIImage(systemName: "multiply"), for: .normal)
        deleteButton.tintColor = .gray
    }
    
    func configureLayout() {
        searchImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.leading.equalTo(contentView).offset(12)
            make.centerY.equalTo(contentView)
        }
        
        searchesLabel.snp.makeConstraints { make in
            make.leading.equalTo(searchImageView.snp.trailing).offset(20)
            make.centerY.equalTo(contentView)
            make.height.equalTo(30)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.trailing.equalTo(contentView).offset(-14)
            make.centerY.equalTo(contentView)
        }
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
