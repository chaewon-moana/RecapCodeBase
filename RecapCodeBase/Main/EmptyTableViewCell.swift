//
//  EmptyTableViewCell.swift
//  RecapProject
//
//  Created by cho on 1/19/24.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {

    @IBOutlet var emptyImageView: UIImageView!
    @IBOutlet var emptyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        emptyImageView.image = .empty
        emptyImageView.contentMode = .scaleAspectFit
        
        emptyLabel.text = "최근 검색어가 없어요"
        emptyLabel.font = .boldHeaderFont
        emptyLabel.textAlignment = .center
    }


    
}
