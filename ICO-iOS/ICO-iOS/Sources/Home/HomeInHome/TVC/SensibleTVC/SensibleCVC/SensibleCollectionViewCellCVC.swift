//
//  SensibleCollectionViewCellCVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/16.
//

import UIKit

class SensibleCollectionViewCellCVC: UICollectionViewCell {
    static let identifier = "SensibleCollectionViewCellCVC"
    @IBOutlet weak var categoryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryLabel.layer.cornerRadius = 8
        categoryLabel.layer.masksToBounds = true
    }

}
