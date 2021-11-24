//
//  UserAlarmSettingTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

class UserAlarmSettingTVC: UITableViewCell {
    static let identifier = "UserAlarmSettingTVC"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
     
    
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
       
    }
    
    @IBAction func didChangeSwitch(_ sender: Any) {
        if alarmSwitch.isOn {
            alarmSwitch.thumbTintColor = .gradient012
        } else {
            alarmSwitch.thumbTintColor = .primaryBlack40
        }

    }
}
