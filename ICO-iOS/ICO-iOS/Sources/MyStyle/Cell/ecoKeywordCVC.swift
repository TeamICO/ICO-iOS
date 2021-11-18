//
//  ecoKeywordCVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/19.
//

import UIKit

class ecoKeywordCVC: UICollectionViewCell {
    
    @IBOutlet weak var ecoIcon: UIImageView!
    @IBOutlet weak var ecoTitle: UILabel!
    @IBOutlet weak var ecoBackColor: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setUI()
    }
    
    func setUI(){
        ecoBackColor.backgroundColor = UIColor.coGreen5
        ecoBackColor.layer.cornerRadius = 8
        ecoTitle.textColor = UIColor.coGreen
        ecoTitle.font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 12)
    }

}
