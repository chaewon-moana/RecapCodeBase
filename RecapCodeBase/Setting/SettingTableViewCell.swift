//
//  SettingTableViewCell.swift
//  RecapProject
//
//  Created by cho on 1/18/24.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet var backView: UIView!
    
    let udManager = UserDefaultManager.shared
    let dataManager = DataManager.profileImageList
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.backgroundColor = .backViewColor
        profileImage.image = UIImage(named: DataManager.profileImageList[udManager.selectedImageIndex])
        profileImage.contentMode = .scaleAspectFit
        
        nicknameLabel.text = udManager.nickname
        nicknameLabel.font = .HeadFont

        likeLabel.attributedText = configureCell(count: udManager.likeList.count)
        likeLabel.font = .BigBodyFont
        
        //profileImage.setImageViewButton(size: 70)
        
    }
    
    func configureCell(count: Int) -> NSAttributedString {
        let text = "\(count)개의 상품을 좋아하고 있어요!"
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: "\(count)개의 상품")
        attributedString.addAttribute(.foregroundColor, value: UIColor.customPointColor, range: range)
        
        return attributedString
    }

}
