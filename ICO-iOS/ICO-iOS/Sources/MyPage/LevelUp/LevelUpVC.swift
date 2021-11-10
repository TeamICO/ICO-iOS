//
//  LevelUpVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

class LevelUpVC: UIViewController {

    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var checkMyLevelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        subTitleLabel.text = "축하드려요!\n나의 에코 레벨이 상승했어요."
        checkMyLevelButton.layer.cornerRadius = 12
        checkMyLevelButton.layer.masksToBounds = true
        checkMyLevelButton.setGradient(color1: UIColor.appColor(.feedbackButtoncolor1), color2: UIColor.appColor(.feedbackButtoncolor2))
    }
    


    @IBAction func didTabpBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func didTapCheckMyLevelButton(_ sender: Any) {
    }
    
}
