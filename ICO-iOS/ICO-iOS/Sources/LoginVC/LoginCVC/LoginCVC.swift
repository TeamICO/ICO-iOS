//
//  LoginCVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/08.
//

import UIKit
import DeviceKit
class LoginCVC: UICollectionViewCell {
    static let identifier = "LoginCVC"
    
    @IBOutlet weak var onboardingImageHeight: NSLayoutConstraint!
    @IBOutlet weak var onboardingImageWeidth: NSLayoutConstraint!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if Device.current.isOneOf(IPhoneDeviceGroup.groupOfAllowedDevices) {
            onboardingImageHeight.constant = 153
            onboardingImageWeidth.constant = 153
        }else{
            onboardingImageHeight.constant = 196
            onboardingImageWeidth.constant = 196
        }
    }

}
