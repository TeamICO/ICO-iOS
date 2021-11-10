//
//  IcoLevelTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

class IcoLevelTVC: UITableViewCell {
    static let identifier = "IcoLevelTVC"
    

    
    @IBOutlet weak var icoLevelImage: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelDes: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
