//
//  BaseViewController.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabbarConfigure()
        // Do any additional setup after loading the view.
    }
    
    func setTabbarConfigure(){
        guard let tabbar = self.tabBarController?.tabBar else{
            return
        }
        tabbar.layer.cornerRadius = 20
        tabbar.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        tabbar.layer.masksToBounds = true
    }
   
}
