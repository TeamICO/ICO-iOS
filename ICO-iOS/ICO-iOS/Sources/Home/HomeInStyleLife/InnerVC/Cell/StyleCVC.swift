//
//  StyleCVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/10.
//

import UIKit

class StyleCVC: UICollectionViewCell {
    
    
    @IBOutlet weak var styleImage: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
        
    }
    
    func setUI(){
        styleImage.cornerRadius = 12
    }

}
