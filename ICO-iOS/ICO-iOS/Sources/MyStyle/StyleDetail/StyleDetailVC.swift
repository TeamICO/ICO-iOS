//
//  StyleDetailVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/16.
//

import UIKit

class StyleDetailVC: UIViewController {

    @IBOutlet weak var navigationTitle: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var heartNum: UILabel!
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreNum: UILabel!
    
    @IBOutlet weak var productDetail: UILabel!
    @IBOutlet weak var lineView1: UIView!
    @IBOutlet weak var lineView2: UIView!
    @IBOutlet weak var urlBackView: UIView!
    @IBOutlet weak var urlProduct: UILabel!
    @IBOutlet weak var moveUrl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        // Do any additional setup after loading the view.
    }
    

    func setUI(){
        productName.text = "톤 28 유기농 손 바를거리"
        productDetail.text = "유기농이라서 착한 성분들로만 구성된 핸드크림이에요. 패키지도 환경을 생각한 게 느껴져서 더 좋았어요. 다만 향기가 호불호가 강하게 들 수 있는 향이라서 만족도 1점 뺍니다 ㅠㅠ"
        productDetail.textColor = UIColor.primaryBlack80
        
        navigationTitle.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 20)
        userImage.contentMode = .scaleAspectFill
        userImage.clipsToBounds = true
        userImage.layer.cornerRadius = 20
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userName.font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 16)
        heartNum.font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 16)
        heartNum.textColor = UIColor.primaryBlack60
        productName.font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 16)
        scoreLabel.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
        scoreNum.font = UIFont.init(name: "AppleSDGothicNeo-Bold", size: 12)
        scoreNum.textColor = UIColor.coGreen
        productDetail.font = UIFont.init(name: "AppleSDGothicNeo-Medium", size: 14)
        lineView1.backgroundColor = UIColor.primaryBlack30
        lineView2.backgroundColor = UIColor.backGround1
        urlBackView.backgroundColor = UIColor.primaryBlack10
        urlBackView.cornerRadius = 16
        urlProduct.font = UIFont.init(name: "AppleSDGothicNeo-Medium", size: 14)
        moveUrl.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
        moveUrl.textColor = UIColor.primaryBlack50
    }
    
    
    @IBAction func toBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func detailBtn(_ sender: Any) {
        let alert = UIAlertController()
        
        let fixAction = UIAlertAction(title: "스타일 수정", style: UIAlertAction.Style.default, handler: nil)
        let deleteAction = UIAlertAction(title: "스타일 삭제", style: UIAlertAction.Style.default, handler: nil)
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(fixAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: false, completion: nil)
    }
    
}
