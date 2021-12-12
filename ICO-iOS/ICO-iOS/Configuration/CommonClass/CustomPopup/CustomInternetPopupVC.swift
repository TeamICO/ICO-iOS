//
//  CustomInternetPopupVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/12/12.
//

import UIKit

class CustomInternetPopupVC: UIViewController {

    @IBOutlet weak var subTitleLabel: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        subTitleLabel.text = "네트워크 상태를 확인하고\n다시 시도해주세요."
    }
    

    @IBAction func didTapButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
