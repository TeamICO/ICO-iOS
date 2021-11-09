//
//  BaseTBC.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//


import Foundation
import UIKit
import CoreMedia
import SwiftUI
class BaseTBC: UITabBarController, UITabBarControllerDelegate{
    
    var customTabBarView = UIView(frame: .zero)
    
    let homeTabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "icNavigationHomeClick1"),tag: 0)
    let mystyleTabBarItem = UITabBarItem(title: "나의 스타일", image: UIImage(named: "icNavigationStyleshot1"),tag: 1)
    let mypageTabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(named: "icNavigationMypage1"),tag: 2)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let homesb = UIStoryboard(name: "HomeSB", bundle: nil)
        let mystlyesb = UIStoryboard(name: "MyStyleSB", bundle: nil)
        let mypagesb = UIStoryboard(name: "MyPageSB", bundle: nil)

        
        
        guard let homeVC = homesb.instantiateViewController(identifier: "HomeVC") as? HomeVC else {return}
        guard let mystlyVC = mystlyesb.instantiateViewController(identifier: "MyStyleVC")as? MyStyleVC else {return }
        guard let mypageVC = mypagesb.instantiateViewController(identifier: "MyPageVC") as? MyPageVC else {return}

        
        let homeNVC = UINavigationController(rootViewController: homeVC)
        let mystyleNVC = UINavigationController(rootViewController: mystlyVC)
        let mypageNVC = UINavigationController(rootViewController: mypageVC)

    
        self.viewControllers = [homeNVC,mystyleNVC,mypageNVC]
        self.delegate = self

        homeNVC.tabBarItem = homeTabBarItem
        mystyleNVC.tabBarItem = mystyleTabBarItem
        mypageNVC.tabBarItem = mypageTabBarItem
    
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium)], for: .normal)
        
       
    }

}
