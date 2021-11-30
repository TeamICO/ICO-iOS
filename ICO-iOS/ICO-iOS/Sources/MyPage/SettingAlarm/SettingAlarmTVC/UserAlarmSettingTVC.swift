//
//  UserAlarmSettingTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

protocol UserAlarmSettingTVCDelelgate : AnyObject{
    func changeAlarm(index : Int, state : String)
}

class UserAlarmSettingTVC: UITableViewCell {
    static let identifier = "UserAlarmSettingTVC"
    
    weak var delegate : UserAlarmSettingTVCDelelgate?
    var index = 0
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
            delegate?.changeAlarm(index: index, state: "Y")
            alarmSwitch.thumbTintColor = .coGreen30
        } else {
            delegate?.changeAlarm(index: index, state: "N")
            alarmSwitch.thumbTintColor = .primaryBlack40
        }

    }
}
