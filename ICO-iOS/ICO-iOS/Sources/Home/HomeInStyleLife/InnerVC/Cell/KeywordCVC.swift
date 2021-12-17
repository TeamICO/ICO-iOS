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
    
    var sortedIdx : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        keywordImg.image = nil
        keywordTitle.text = nil
    }
    
    func setUI(index : Int,isSeleted : Bool){
        switch index{
        case 0 :
            keywordImg.image = UIImage(named: "illust-styleshot-upcycling")
            keywordTitle.text = "업사이클링"
            break
        case 1 :
            keywordImg.image = UIImage(named: "illust-styleshot-vegan")
            keywordTitle.text = "비건"
            break
        case 2 :
            keywordImg.image = UIImage(named: "illust-styleshot-energy")
            keywordTitle.text = "에너지절약"
            break
        case 3 :
            keywordImg.image = UIImage(named: "illust-product-package")
            keywordTitle.text = "제로웨이스트"
            break
        case 4 :
            keywordImg.image = UIImage(named: "illust-styleshot-cleanbeauty")
            keywordTitle.text = "클린뷰티"
            break
        case 5 :
            keywordImg.image = UIImage(named: "illust-styleshot-organic")
            keywordTitle.text = "유기농"
            break
        case 6 :
            keywordImg.image = UIImage(named: "illust-styleshot-value")
            keywordTitle.text = "가치"
            break
        default :
            break
        }
        if isSeleted{
            colorView.backgroundColor = UIColor.gradient012
            keywordTitle.textColor = UIColor.white
            keywordTitle.font = UIFont.init(name: "AppleSDGothicNeo-Semibold", size: 14)
        }else{
            keywordTitle.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 14)
            if index == 0{
                colorView.backgroundColor = UIColor.coGreen5
                keywordTitle.textColor = UIColor.upcyclingGreen
            }else if index == 1{
                colorView.backgroundColor = UIColor.lightSuccess
                keywordTitle.textColor = UIColor.alertsSuccess
            }else if index == 2{
                colorView.backgroundColor = UIColor.lightInfo
                keywordTitle.textColor = UIColor.alertsInfo
            }else if index == 3{
                colorView.backgroundColor = UIColor.lightWarning
                keywordTitle.textColor = UIColor.alertWarning
            }else if index == 4{
                colorView.backgroundColor = UIColor.lightShadow
                keywordTitle.textColor = UIColor.coGreen
            }else if index == 5{
                colorView.backgroundColor = UIColor.lightError
                keywordTitle.textColor = UIColor.alertsError
            }else {
                colorView.backgroundColor = UIColor.lightPoint
                keywordTitle.textColor = UIColor.point
            }
            
        }

        colorView.cornerRadius = 12
       
    }

  

}
