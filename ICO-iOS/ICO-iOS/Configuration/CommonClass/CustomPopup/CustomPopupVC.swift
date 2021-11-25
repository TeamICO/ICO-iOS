//
//  CustomPopupVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/25.
//

import UIKit

class CustomPopupVC: UIViewController {
    var text = ""
    @IBOutlet weak var alertLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alertLabel.text = text
        // Do any additional setup after loading the view.
    }
    

    @IBAction func hidePopupView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
