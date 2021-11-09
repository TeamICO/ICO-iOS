//
//  MyStyleVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//

import UIKit

class MyStyleVC: BaseViewController {
    
    @IBOutlet weak var navigationTitle: UILabel!
    
    @IBOutlet weak var backView: UIView!
    

    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var profileline: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    
    
    @IBOutlet var keywordView: [UIView]!
    
    @IBOutlet var keywordName: [UILabel]!
    
    
    @IBOutlet weak var likeNum: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var styleNum: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        // Do any additional setup after loading the view.
    }
    
    func setUI(){
        navigationTitle.text = "나의 스타일"
        navigationTitle.font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 20)

 
        backView.backgroundColor = UIColor.lightShadow
        lineView.backgroundColor = UIColor.primaryBlack40
            
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowColor = UIColor.init(red: 0.288, green: 0.288, blue: 0.288, alpha: 0.1).cgColor
        shadowView.layer.shadowRadius = 13
        shadowView.layer.cornerRadius = 16
        shadowView.layer.shadowOffset = CGSize(width: 8, height: 8)
            
        profileImage.cornerRadius = 12
        name.text = "이석"
        name.font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 20)
        keywordLabel.text = "에코 관심 키워드"
        keywordLabel.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
        profileline.backgroundColor = UIColor.primaryBlack50
        detailLabel.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
        detailLabel.textColor = UIColor.primaryBlack60
        detailLabel.text = "지구를 위해 지속가능한 패션 제품을 소비하려고 노력합니다."
            
            keywordName[0].text = "업사이클링"
            keywordName[1].text = "수익기부"
            keywordName[2].text = "무향료"
            for i in 0...2{
                keywordView[i].backgroundColor = UIColor.primaryigreen5
                keywordView[i].cornerRadius = 8
                keywordName[i].textColor = UIColor.coGreen
            }
            
            
            likeLabel.text = "누적 좋아요"
            likeNum.text = "230"
            styleLabel.text = "누적 스타일 샷"
            styleNum.text = "8"
            likeNum.font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 24)
            likeLabel.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
            likeLabel.textColor = UIColor.primaryBlack60
            styleNum.font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 24)
            styleLabel.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
            styleLabel.textColor = UIColor.primaryBlack60
            
        
    }

}
