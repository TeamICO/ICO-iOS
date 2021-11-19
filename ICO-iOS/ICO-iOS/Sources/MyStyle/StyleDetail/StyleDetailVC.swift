//
//  StyleDetailVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/16.
//

import UIKit

class StyleDetailVC: UIViewController {

    var isMine : Bool = true
    var styleShotIdx: Int = 0
    var StyleDetailData: StyleDetailResult?
    
    @IBOutlet weak var categoryCV: UICollectionView!
    @IBOutlet weak var hashtagCV: UICollectionView!
    @IBOutlet weak var navigationTitle: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var heartNum: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var ecoLevelImg: UIImageView!
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

        StyleDetailDataManager().getStyleDetail(self, styleShotIdx: styleShotIdx)
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
        
        if isMine == true{
            let fixAction = UIAlertAction(title: "스타일 수정", style: UIAlertAction.Style.default, handler: nil)
            fixAction.setValue(UIColor.coGreen, forKey: "titleTextColor")
            let deleteAction = UIAlertAction(title: "스타일 삭제", style: UIAlertAction.Style.default, handler: nil)
            deleteAction.setValue(UIColor.alertsError, forKey: "titleTextColor")
            let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
            cancelAction.setValue(UIColor.primaryBlack70, forKey: "titleTextColor")
            
            alert.addAction(fixAction)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
        }else{
            let reportAction = UIAlertAction(title: "신고하기", style: UIAlertAction.Style.default){ (_) in
                let alertController = UIAlertController(title: nil, message: "신고사유를 선택해주세요",preferredStyle: .actionSheet)
                
                let reason1Action = UIAlertAction(title: "욕설 및 비하", style: UIAlertAction.Style.default, handler: nil)
                reason1Action.setValue(UIColor.coGreen, forKey: "titleTextColor")
                let reason2Action = UIAlertAction(title: "음란물 및 성적 불쾌감", style: UIAlertAction.Style.default, handler: nil)
                reason2Action.setValue(UIColor.coGreen, forKey: "titleTextColor")
                let reason3Action = UIAlertAction(title: "사기 및 거짓 정보", style: UIAlertAction.Style.default, handler: nil)
                reason3Action.setValue(UIColor.coGreen, forKey: "titleTextColor")
                let reason4Action = UIAlertAction(title: "상업적 광고", style: UIAlertAction.Style.default, handler: nil)
                reason4Action.setValue(UIColor.coGreen, forKey: "titleTextColor")
                let reason5Action = UIAlertAction(title: "지적재산권 및 저작권 침해", style: UIAlertAction.Style.default, handler: nil)
                reason5Action.setValue(UIColor.coGreen, forKey: "titleTextColor")
                let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
                cancelAction.setValue(UIColor.primaryBlack70, forKey: "titleTextColor")
                
                alertController.addAction(reason1Action)
                alertController.addAction(reason2Action)
                alertController.addAction(reason3Action)
                alertController.addAction(reason4Action)
                alertController.addAction(reason5Action)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: false, completion: nil)
            }
            reportAction.setValue(UIColor.alertsError, forKey: "titleTextColor")
            
            let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
            cancelAction.setValue(UIColor.primaryBlack70, forKey: "titleTextColor")
            
            alert.addAction(reportAction)
            alert.addAction(cancelAction)
        }
        self.present(alert, animated: false, completion: nil)
    }
    
}

extension StyleDetailVC{
    func didSuccessStyleDetail(message: String){
        self.productImage.setImage(with: StyleDetailData?.imageURL ?? "")
        self.userImage.setImage(with: StyleDetailData?.profileURL ?? "")
        self.userName.text = StyleDetailData?.nickname
        self.productName.text = StyleDetailData?.productName
        self.heartNum.text = "\(StyleDetailData?.likeCnt ?? 0)"
        self.scoreNum.text = "\(StyleDetailData?.point ?? 0)"
        if scoreNum.text == "5"{
           ecoLevelImg.image = UIImage(named: "ic-styleshot-upload-ecolevel-5")
        }else if scoreNum.text == "4"{
           ecoLevelImg.image = UIImage(named: "ic-styleshot-upload-ecolevel-4")
        }else if scoreNum.text == "3"{
           ecoLevelImg.image = UIImage(named: "ic-styleshot-upload-ecolevel-3")
        }else if scoreNum.text == "2"{
           ecoLevelImg.image = UIImage(named: "ic-styleshot-upload-ecolevel-2")
        }else if scoreNum.text == "1"{
           ecoLevelImg.image = UIImage(named: "ic-styleshot-upload-ecolevel-1")
        }
        self.productDetail.text = StyleDetailData?.resultDescription
        self.urlProduct.text = StyleDetailData?.productName
        
        print(message)
    }
}
