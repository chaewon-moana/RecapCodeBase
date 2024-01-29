//
//  ProductCollectionViewCell.swift
//  RecapProject
//
//  Created by cho on 1/19/24.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var likeBackView: UIView!
    @IBOutlet var backImageView: UIView!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var mallNameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    let udManager = UserDefaultManager.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        likeBackView.layer.cornerRadius = 35/2
        likeBackView.backgroundColor = .white

        
        mallNameLabel.text = "mallName"
        titleLabel.text = "titleLabel"
        priceLabel.text = "priceLabel"
    }
    
    func configureCell(data: Product) {
        let imageURL = URL(string: data.image)
        productImageView.kf.setImage(with: imageURL)
        productImageView.contentMode = .scaleAspectFill
        productImageView.layer.cornerRadius = 8
        productImageView.clipsToBounds = true
        
        likeButton.setTitle("", for: .normal)
        likeButton.tintColor = .black
        
        //TODO: lickImageView와 관련된 데이터셋 만들어서 true, false에 따라서 heart.fill과 heart 보여주기
        
        mallNameLabel.text = data.mallName
        mallNameLabel.font = .smallBodyFont
        mallNameLabel.textColor = .textGrayColor
        
        var title = data.title.replacingOccurrences(of: "<b>", with: "")
        title = title.replacingOccurrences(of: "</b>", with: "")
        titleLabel.text = title
        titleLabel.numberOfLines = 2
        titleLabel.font = .middleBodyFont
        titleLabel.textColor = .customTextColor
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: Int(data.lprice))
        priceLabel.text = result
        priceLabel.textColor = .customTextColor
        priceLabel.font = .boldBigBodyFont
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        
    }
}
