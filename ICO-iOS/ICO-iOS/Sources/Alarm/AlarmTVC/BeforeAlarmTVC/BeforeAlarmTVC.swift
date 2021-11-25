//
//  BeforeAlarmTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/11.
//

import UIKit

class BeforeAlarmTVC: UITableViewCell {
    static let identifier = "BeforeAlarmTVC"
    @IBOutlet weak var categoryIconImage: UIImageView!
    @IBOutlet weak var categoryLabel: BasePaddingLabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var alarmedLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryLabel.layer.cornerRadius = 8
        categoryLabel.layer.masksToBounds = true
    }

    override func prepareForReuse() {
        self.categoryIconImage.image = nil
        self.categoryLabel.text = nil
        self.contentLabel.text = nil
        self.alarmedLabel.text = nil
    }
    
    func configure(with viewModel : AlarmViewModel){
        self.alarmedLabel.text = viewModel.time
        self.contentLabel.text = viewModel.description
 
        switch viewModel.type{
        case "url":
            categoryLabel.text = "프로모션"
            categoryIconImage.image = UIImage(named: "icAlramStyleshotRecent1")
           
            break
        case "styleshotIdx":
            categoryLabel.text = "나의 스타일"
            categoryIconImage.image = UIImage(named: "icNavigationStyleshot1")
            
            break
        case "mypage" :
            categoryLabel.text = "마이페이지"
            categoryIconImage.image = UIImage(named: "icNavigationMypage1")
            
            break
            
        case "like" :
            categoryLabel.text = "나의 스타일"
            categoryIconImage.image = UIImage(named: "icNavigationStyleshot1")
           
            break
        default :
            break
            
        }
        
        
    }
    
}
