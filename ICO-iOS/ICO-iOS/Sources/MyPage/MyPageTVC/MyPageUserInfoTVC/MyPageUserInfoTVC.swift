//
//  MyPageUserInfoTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

protocol MyPageUserInfoTVCDelegate : AnyObject{
    func didTapIcoButton()
}

class MyPageUserInfoTVC: UITableViewCell {
    static let identifier = "MyPageUserInfoTVC"
    
    weak var delegate : MyPageUserInfoTVCDelegate?
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userIcoLevelImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var secondUserNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    @IBAction func didTapIcoButton(_ sender: Any) {
        delegate?.didTapIcoButton()
    }
    
}
