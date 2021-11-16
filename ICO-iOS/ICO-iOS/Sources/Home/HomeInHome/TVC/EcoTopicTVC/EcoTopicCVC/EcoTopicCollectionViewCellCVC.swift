//
//  EcoTopicCollectionViewCellCVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/16.
//

import UIKit

class EcoTopicCollectionViewCellCVC: UICollectionViewCell {
    static let identifier = "EcoTopicCollectionViewCellCVC"
    @IBOutlet weak var categoryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryLabel.layer.cornerRadius = 8
        categoryLabel.layer.masksToBounds = true
    }

}
