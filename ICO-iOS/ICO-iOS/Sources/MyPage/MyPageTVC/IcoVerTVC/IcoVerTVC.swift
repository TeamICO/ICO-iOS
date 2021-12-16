//
//  IcoVerTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

class IcoVerTVC: UITableViewCell {
    static let identifier = "IcoVerTVC"
    @IBOutlet weak var verLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        verLabel.text = Constant.VER
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
