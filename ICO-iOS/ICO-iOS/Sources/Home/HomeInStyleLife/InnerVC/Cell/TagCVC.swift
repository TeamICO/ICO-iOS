//
//  TagCVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/18.
//

import UIKit

class TagCVC: UICollectionViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryLabel.layer.cornerRadius = 8
        categoryLabel.layer.masksToBounds = true
        categoryLabel.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
    }

}
