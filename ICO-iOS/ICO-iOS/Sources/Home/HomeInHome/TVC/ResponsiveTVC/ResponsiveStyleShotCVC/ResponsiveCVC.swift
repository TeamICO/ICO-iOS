//
//  ResponsiveCVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/05.
//

import UIKit

class ResponsiveCVC: UICollectionViewCell {
    static let identifier = "ResponsiveCVC"
        
    let cartegoryModels = ["유기농", "클린뷰티","ㅁㄴㅇㅁ"]
    let cartegoryFontColors : [UIColor] = [UIColor.appColor(.categoryFontRed),UIColor.appColor(.categoryFontGreen),UIColor.appColor(.categoryFontGreen)]
    let cartegoryBackColors : [UIColor] = [UIColor.appColor(.categoryBackgroundRed),UIColor.appColor(.categoryBackgroundGreen),UIColor.appColor(.categoryBackgroundGreen)]
    @IBOutlet weak var userContentImage: UIImageView!
    
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var gradientView2: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var userSatisfactionStack: UIStackView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        gradientView.setGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: .white)
        gradientView2.setGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: .white)
        
        
        setCellShadow()
        setStackView()
        setUserSatisfactionStack()
    }
    //MARK : StackView Configure
    func setStackView(){
        for i in 0...2{
            let stack = SensibleSV()
            stack.categoryLabel.text = cartegoryModels[i]
            stack.categoryLabel.textColor = cartegoryFontColors[i]
            stack.categoryLabel.backgroundColor = cartegoryBackColors[i]
            stackView.addArrangedSubview(stack)
        }
    }
    func setUserSatisfactionStack(){
        for i in 0...4{
            let stack = UserRatingsSV()
            userSatisfactionStack.addArrangedSubview(stack)
        }
    }
    //MARK : Cell Configure
    func setCellShadow(){
        content.layer.shadowColor = UIColor(red: 0.188, green: 0.188, blue: 0.188, alpha: 0.1).cgColor
        content.layer.shadowOpacity = 1
        content.layer.shadowRadius = 16
        content.layer.cornerRadius = 16
        content.layer.shadowOffset = CGSize(width: 10, height: 10)
        
    }
}

