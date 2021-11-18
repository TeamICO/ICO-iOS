//
//  LikeCollectionViewCellCVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/18.
//

import UIKit

class LikeCollectionViewCellCVC: UICollectionViewCell {
    static let identifier = "LikeCollectionViewCellCVC"
    @IBOutlet weak var categoryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryLabel.layer.cornerRadius = 8
        categoryLabel.layer.masksToBounds = true
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.text = nil
    }

}
