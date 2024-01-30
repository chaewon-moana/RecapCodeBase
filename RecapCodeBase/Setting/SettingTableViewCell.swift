//
//  SettingTableViewCell.swift
//  RecapProject
//
//  Created by cho on 1/18/24.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell, CodeBase {

    let profileImage = ProfileImageView(frame: .zero)
    let nicknameLabel = UILabel()
    let likeLabel = UILabel()

    let udManager = UserDefaultManager.shared
    let dataManager = DataManager.profileImageList
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setAddView()
        configureLayout()
        configureAttribute()
    }
    
    func setAddView() {
        contentView.addSubviews([profileImage, nicknameLabel, likeLabel])
    }
    
    func configureAttribute() {
        profileImage.image = UIImage(named: DataManager.profileImageList[udManager.selectedImageIndex])
        
        nicknameLabel.text = "닉네임ㄴ닉네임닉네임"//udManager.nickname
        nicknameLabel.font = .HeadFont

        likeLabel.attributedText = configureCell(count: udManager.likeList.count)
        likeLabel.font = .BigBodyFont
    }

    func configureLayout() {
        profileImage.snp.makeConstraints { make in
            make.size.equalTo(70)
            make.centerY.equalTo(contentView)
            make.leading.equalTo(20)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.leading.equalTo(profileImage.snp.trailing).offset(20)
            make.centerY.equalTo(contentView).offset(-12)
        }
        
        likeLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.equalTo(profileImage.snp.trailing).offset(20)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(2)
        }
    }

    func configureCell(count: Int) -> NSAttributedString {
        let text = "\(count)개의 상품을 좋아하고 있어요!"
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: "\(count)개의 상품")
        attributedString.addAttribute(.foregroundColor, value: UIColor.customPointColor, range: range)
        
        return attributedString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
