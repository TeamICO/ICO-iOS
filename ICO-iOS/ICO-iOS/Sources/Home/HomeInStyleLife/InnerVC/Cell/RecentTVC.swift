//
//  RecentTVC.swift
//  ICO
//
//  Created by 이은영 on 2021/11/04.
//

import UIKit

class RecentTVC: UITableViewCell {
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var heartNum: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var ecoLevelImg: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var detailText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.text = "라일리"
        heartNum.text = "11"
        productName.text = "톤28 유기농 손 바를거리"
        score.textColor = .coGreen
        detailLabel.text = "너무 귀여운 거 아닌그..."
        time.textColor = UIColor.tabBarGray
        time.text = "10분 전"
        time.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
        userImage.contentMode = .scaleAspectFill
        userImage.clipsToBounds = true
        userImage.layer.cornerRadius = 20
        userImage.translatesAutoresizingMaskIntoConstraints = false
        detailView.cornerRadius = 8
        detailText.textColor = .alertWarning
        detailView.backgroundColor = .lightWarning
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
