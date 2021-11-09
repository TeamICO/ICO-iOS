//
//  BrandCVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/03.
//

import UIKit

class BrandCVC: UICollectionViewCell {
    static let identifier = "BrandCVC"
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var gradientView: UIView!
    override func awakeFromNib() {
        gradientView.setGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: .white)
        
        
        super.awakeFromNib()
        // Initialization code
    }

}
