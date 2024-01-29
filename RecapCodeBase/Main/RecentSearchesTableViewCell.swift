//
//  RecentSearchesTableViewCell.swift
//  RecapProject
//
//  Created by cho on 1/18/24.
//

import UIKit

class RecentSearchesTableViewCell: UITableViewCell {

    @IBOutlet var magnifyingglassImageView: UIImageView!
    @IBOutlet var searchesLabel: UILabel!
    @IBOutlet var deleteButton: UIButton!
    
    //TODO: deleteButton 눌렀을 때, 해당 cell 삭제되게 만들기
    //TODO: 해당 cell을 누르면 검색어창으로 이동
    override func awakeFromNib() {
        super.awakeFromNib()
        
        magnifyingglassImageView.image = UIImage(systemName: "magnifyingglass")
        magnifyingglassImageView.tintColor = .white
        
        searchesLabel.font = .smallBodyFont
        searchesLabel.textColor = .lightGray
        
        deleteButton.setTitle("", for: .normal)
        deleteButton.setImage(UIImage(systemName: "multiply"), for: .normal)
        deleteButton.setTitleColor(.customTextColor, for: .normal)
        deleteButton.tintColor = .lightGray
    }

 

    
}
