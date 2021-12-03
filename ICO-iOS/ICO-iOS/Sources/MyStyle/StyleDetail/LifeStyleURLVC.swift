//
//  LifeStyleURLVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/12/03.
//

import UIKit

class LifeStyleURLVC: UIViewController {
    
    @IBOutlet weak var alertLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        alertLabel.text = "아이코는 해당 상품 페이지와 관련이 없으며,\n제품에 대한 모든 거래의 책임은 해당 쇼핑몰에\n있으니 참고부탁드립니다."
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
