//
//  TodayAlarmTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/11.
//

import UIKit

class TodayAlarmTVC: UITableViewCell {
    static let identifier = "TodayAlarmTVC"
    @IBOutlet weak var categoryIconImage: UIImageView!
    @IBOutlet weak var categoryLabel: BasePaddingLabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var alarmedLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
