//
//  ProductCollectionViewCell.swift
//  RecapProject
//
//  Created by cho on 1/19/24.
//

import UIKit
import Kingfisher
import SnapKit

class ProductCollectionViewCell: UICollectionViewCell, CodeBase {
    
    let likeButton = UIButton()
    let likeBackView = UIView()
    let productImageView = UIImageView()
    let mallNameLabel = UILabel()
    let titleLabel = UILabel()
    let priceLabel = UILabel()

    let udManager = UserDefaultManager.shared
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAddView()
        configureLayout()
        configureAttribute()
    }

    func setAddView() {
        contentView.addSubviews([productImageView, mallNameLabel, titleLabel, priceLabel, likeBackView])
        likeBackView.addSubview(likeButton)
    }
    
    func configureAttribute() {
        isUserInteractionEnabled = true
        
        productImageView.contentMode = .scaleAspectFill
        productImageView.layer.cornerRadius = 8
        productImageView.clipsToBounds = true
        
        likeButton.setTitle("", for: .normal)
        likeButton.tintColor = .black
        
        likeBackView.layer.cornerRadius = 35/2
        likeBackView.backgroundColor = .white
        
        mallNameLabel.font = .smallBodyFont
        mallNameLabel.textColor = .textGrayColor
        
        titleLabel.numberOfLines = 2
        titleLabel.font = .middleBodyFont
        titleLabel.textColor = .customTextColor
        
        priceLabel.textColor = .customTextColor
        priceLabel.font = .boldBigBodyFont
        
    }
    
    func configureLayout() {
        productImageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(contentView).inset(5)
            make.height.equalTo(180)
        }
        
        likeBackView.snp.makeConstraints { make in
            make.size.equalTo(35)
            make.bottom.trailing.equalTo(productImageView).inset(5)
        }
        
        likeButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.edges.equalToSuperview()
        }
        
        mallNameLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.top.equalTo(productImageView.snp.bottom).offset(4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.width.equalTo(150)
            make.height.lessThanOrEqualTo(36)
            make.top.equalTo(mallNameLabel.snp.bottom).offset(4)
        }
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.height.equalTo(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
    }
    
    func configureCell(data: Product) {
        let imageURL = URL(string: data.image)
        productImageView.kf.setImage(with: imageURL)
        mallNameLabel.text = data.mallName

        var title = data.title.replacingOccurrences(of: "<b>", with: "")
        title = title.replacingOccurrences(of: "</b>", with: "")
        titleLabel.text = title

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: Int(data.lprice))
        priceLabel.text = result

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
