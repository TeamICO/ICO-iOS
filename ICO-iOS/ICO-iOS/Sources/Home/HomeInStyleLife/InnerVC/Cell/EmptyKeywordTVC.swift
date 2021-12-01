//
//  EmptyKeywordTVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/12/01.
//

import UIKit

class EmptyKeywordTVC: UITableViewCell {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
    }
    
    
    func setUI(){
        alertTitle.textColor = UIColor.alertsInfo
        alertTitle.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
        alertView?.layer.cornerRadius = 8
        alertView?.layer.borderWidth = 1
        alertView?.layer.borderColor = UIColor.primaryBlack20.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
