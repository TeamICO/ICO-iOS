//
//  ProfileMyEcoKeywordTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/11.
//

import UIKit

class ProfileMyEcoKeywordTVC: UITableViewCell {
    static let identifier = "ProfileMyEcoKeywordTVC"
    
    @IBOutlet weak var donationView: UIView!
    
    @IBOutlet weak var animalView: UIView!
    
    @IBOutlet weak var tradeView: UIView!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }
    
}

