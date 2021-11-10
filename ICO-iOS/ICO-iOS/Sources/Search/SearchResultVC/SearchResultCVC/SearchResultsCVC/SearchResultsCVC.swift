//
//  SearchResultsCVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

class SearchResultsCVC: UICollectionViewCell {
    static let identifier = "SearchResultsCVC"
    
    let cartegoryModels = ["유기농", "클린뷰티"]
    let cartegoryFontColors : [UIColor] = [UIColor.appColor(.categoryFontRed),UIColor.appColor(.categoryFontGreen)]
    let cartegoryBackColors : [UIColor] = [UIColor.appColor(.categoryBackgroundRed),UIColor.appColor(.categoryBackgroundGreen)]
    
    @IBOutlet weak var userContentImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var gradientView: UIView!
    
    // MARK : Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        gradientView.setGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: .white)
        
        
        setStackView()
    }
    //MARK : StackView Configure
    func setStackView(){
        for i in 0...1{
     
                let stack = SearchResultsSV()
                stack.categoryLabel.text = cartegoryModels[i]
                stack.categoryLabel.textColor = cartegoryFontColors[i]
                stack.categoryLabel.backgroundColor = cartegoryBackColors[i]
                stackView.addArrangedSubview(stack)
            
        }
    }
  
}
