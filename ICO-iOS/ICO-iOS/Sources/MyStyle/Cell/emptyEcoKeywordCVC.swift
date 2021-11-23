//
//  emptyEcoKeywordCVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/23.
//

import UIKit

class emptyEcoKeywordCVC: UICollectionViewCell {
    
    @IBOutlet weak var emptyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        emptyLabel.textColor = UIColor.primaryBlack40
    }

}
