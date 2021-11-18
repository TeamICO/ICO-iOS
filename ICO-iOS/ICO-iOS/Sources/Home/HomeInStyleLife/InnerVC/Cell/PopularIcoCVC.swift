//
//  PopularIcoCVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/08.
//

import UIKit

class PopularIcoCVC: UICollectionViewCell {
    
    @IBOutlet weak var icoImage: UIImageView!
    @IBOutlet weak var icoName: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var backgroundIcon: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
    }
    
    
    func setUI(){
        icoName.font = UIFont.init(name: "AppleSDGothicNeo-Medium", size: 14)
        icoName.text = "라일리"
        icoImage.cornerRadius = 5
        
        icoImage.addCircleGradiendBorder(5)
        
        backgroundIcon.cornerRadius = 12
        icoImage.bringSubviewToFront(backgroundIcon)
        backgroundIcon.bringSubviewToFront(iconImage)
    }

}
