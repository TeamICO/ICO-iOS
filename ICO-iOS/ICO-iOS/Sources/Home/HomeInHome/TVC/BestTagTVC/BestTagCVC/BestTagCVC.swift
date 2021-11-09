//
//  BestTagCVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/03.
//

import UIKit

class BestTagCVC: UICollectionViewCell {
    static let identifier = "BestTagCVC"
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var producImage: UIImageView!
    @IBOutlet weak var brandNameLabel: UILabel!
    
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        gradientView.setGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: .white)
        
    }
    func setStackView(){
        for i in 0...1{
            let stack = BestTagSV()

            stackView.addArrangedSubview(stack)
        }
    }
}
