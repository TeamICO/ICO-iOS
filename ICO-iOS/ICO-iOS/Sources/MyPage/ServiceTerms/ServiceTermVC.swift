//
//  ServiceTermVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/20.
//

import UIKit

class ServiceTermVC: UIViewController {

    @IBOutlet weak var termsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        termsLabel.text = Terms().serviceTerm
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
