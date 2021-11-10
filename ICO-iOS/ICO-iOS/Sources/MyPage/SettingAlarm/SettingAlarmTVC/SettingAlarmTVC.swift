//
//  SettingAlarmTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit
protocol SettingAlarmTVCDelegate : AnyObject{
    func setUserAlarm()
}

class SettingAlarmTVC: UITableViewCell {
    static let identifier = "SettingAlarmTVC"
    
    weak var delegate : SettingAlarmTVCDelegate?
    
    @IBOutlet weak var alarmView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        setTapGesture()
    }
    
    func setTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(setUserAlarm))
        viewTap.cancelsTouchesInView = false
        alarmView.addGestureRecognizer(viewTap)
    }
    @objc func setUserAlarm(){
        delegate?.setUserAlarm()
    }
    
}
