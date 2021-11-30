//
//  LevelUpVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

class LevelUpVC: UIViewController {
    public var completion : ((Bool)->Void)?
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var checkMyLevelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        subTitleLabel.text = "축하드려요!\n나의 에코 레벨이 상승했어요."
        checkMyLevelButton.layer.cornerRadius = 12
        checkMyLevelButton.layer.masksToBounds = true
        if UIDevice.current.userInterfaceIdiom == .pad {
            checkMyLevelButton.backgroundColor = .gradient01
        }else{
            checkMyLevelButton.setGradient(color1: UIColor.appColor(.feedbackButtoncolor1), color2: UIColor.appColor(.feedbackButtoncolor2))
           
        }
       
    }
    


    @IBAction func didTabpBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func didTapCheckMyLevelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.01) {
            self.completion?(true)
        }
    }
    
}
