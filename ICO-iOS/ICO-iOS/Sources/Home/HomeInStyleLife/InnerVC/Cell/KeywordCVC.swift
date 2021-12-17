//
//  KeywordCVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/11.
//

import UIKit

protocol KeywordCVCDelagate : AnyObject{
    //func didTapSort(sortedIdx : Int)
    func didTapSelected(sortedIdx: Int)
    func didTapDeselected(sortedIdx: Int)
}


class KeywordCVC: UICollectionViewCell {
    
    weak var delegate : KeywordCVCDelagate?
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var keywordImg: UIImageView!
    @IBOutlet weak var keywordTitle: UILabel!
    
    var sortedIdx : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    /*
    override func prepareForReuse() {
        delegate?.didTapSelected(sortedIdx: sortedIdx)
        delegate?.didTapDeselected(sortedIdx: sortedIdx)
    }*/
    
    func setUI(){
        colorView.cornerRadius = 12
        keywordTitle.font = UIFont.init(name: "AppleSDGothicNeo-Medium", size: 14)
    }
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                /*
                colorView.backgroundColor = UIColor.gradient012
                keywordTitle.textColor = UIColor.white
                keywordTitle.font = UIFont.init(name: "AppleSDGothicNeo-Semibold", size: 14)*/
                delegate?.didTapSelected(sortedIdx: sortedIdx)
            }else{
                keywordTitle.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 14)
                if keywordTitle.text == "비건"{
                    colorView.backgroundColor = UIColor.lightSuccess
                    keywordTitle.textColor = UIColor.alertsSuccess
                }else if keywordTitle.text == "업사이클링"{
                    colorView.backgroundColor = UIColor.coGreen5
                    keywordTitle.textColor = UIColor.upcyclingGreen
                }else if keywordTitle.text == "제로웨이스트"{
                    colorView.backgroundColor = UIColor.lightWarning
                    keywordTitle.textColor = UIColor.alertWarning
                }else if keywordTitle.text == "가치"{
                    colorView.backgroundColor = UIColor.lightPoint
                    keywordTitle.textColor = UIColor.point
                }else if keywordTitle.text == "유기농"{
                    colorView.backgroundColor = UIColor.lightError
                    keywordTitle.textColor = UIColor.alertsError
                }else if keywordTitle.text == "클린뷰티"{
                    colorView.backgroundColor = UIColor.lightShadow
                    keywordTitle.textColor = UIColor.coGreen
                }else{
                    colorView.backgroundColor = UIColor.lightInfo
                    keywordTitle.textColor = UIColor.alertsInfo
                }
                delegate?.didTapDeselected(sortedIdx: sortedIdx)
            } 
        }
    }

}
