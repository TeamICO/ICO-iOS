//
//  KeywordCVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/11.
//

import UIKit

class KeywordCVC: UICollectionViewCell {
    
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var keywordImg: UIImageView!
    @IBOutlet weak var keywordTitle: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     
    }
    
    func setUI(){
        colorView.cornerRadius = 12
        keywordTitle.font = UIFont.init(name: "AppleSDGothicNeo-Medium", size: 14)
    }

}
