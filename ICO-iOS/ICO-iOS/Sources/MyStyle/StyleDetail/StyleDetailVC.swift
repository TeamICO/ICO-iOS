//
//  StyleDetailVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/16.
//

import UIKit
import SafariServices

class StyleDetailVC: UIViewController {

    var isMine : Bool = true
    var styleShotIdx: Int = 0
    var StyleDetailData: StyleDetailResult?
    var url: NSURL?
    
    @IBOutlet weak var categoryCV: UICollectionView!
    @IBOutlet weak var hashtagCV: UICollectionView!
    @IBOutlet weak var navigationTitle: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var heartNum: UILabel!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var ecoLevelImg: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreNum: UILabel!
    
    
    @IBOutlet weak var gradientView1: UIView!
    @IBOutlet weak var gradientView2: UIView!
    @IBOutlet weak var productDetail: UILabel!
    @IBOutlet weak var lineView1: UIView!
    @IBOutlet weak var lineView2: UIView!
    @IBOutlet weak var urlBackView: UIView!
    @IBOutlet weak var urlProduct: UILabel!
    @IBOutlet weak var moveUrl: UILabel!
    @IBOutlet weak var moveUrlBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        StyleDetailDataManager().getStyleDetail(self, styleShotIdx: styleShotIdx)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        StyleDetailDataManager().getStyleDetail(self, styleShotIdx: styleShotIdx)
        setUI()
        categoryCV.register(UINib(nibName: "TagCVC", bundle: nil), forCellWithReuseIdentifier: "TagCVC")
        hashtagCV.register(UINib(nibName: "TagCVC", bundle: nil), forCellWithReuseIdentifier: "TagCVC")
        // Do any additional setup after loading the view.
    }
    

    func setUI(){
        gradientView1.setGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: .white)
        gradientView2.setGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: .white)
        
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
        scoreLabel.text = "만족도"
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
            let fixAction = UIAlertAction(title: "스타일 수정", style: UIAlertAction.Style.default){ action in
                let uploadSB = UIStoryboard(name: "StyleUpload", bundle: nil)
                let uploadVC = uploadSB.instantiateViewController(withIdentifier: "StyleUploadVC")as? StyleUploadVC
                uploadVC?.isFix = true
                self.navigationController?.pushViewController(uploadVC!, animated: true)
            }
            fixAction.setValue(UIColor.coGreen, forKey: "titleTextColor")
            let deleteAction = UIAlertAction(title: "스타일 삭제", style: UIAlertAction.Style.default){ action in
                let deleteRequest = StyleDeleteRequest(status: "N")
                StyleDetailDataManager().deleteStyleDetail(deleteRequest, self, styleshotIdx: self.styleShotIdx)
                self.navigationController?.popViewController(animated: true)
            }
            deleteAction.setValue(UIColor.alertsError, forKey: "titleTextColor")
            let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
            cancelAction.setValue(UIColor.primaryBlack70, forKey: "titleTextColor")
            
            alert.addAction(fixAction)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
        }else{
            let reportAction = UIAlertAction(title: "신고하기", style: UIAlertAction.Style.default){ (_) in
                let alertController = UIAlertController(title: nil, message: "신고사유를 선택해주세요",preferredStyle: .actionSheet)
                
                let reason1Action = UIAlertAction(title: "욕설 및 비하", style: UIAlertAction.Style.default){ action in
                    let request1 = StyleReportRequest(reason: "욕설 및 비하", styleshotIdx: self.styleShotIdx)
                    StyleDetailDataManager().reportStyleDetail(request1, self)
                }
                reason1Action.setValue(UIColor.coGreen, forKey: "titleTextColor")
                let reason2Action = UIAlertAction(title: "음란물 및 성적 불쾌감", style: UIAlertAction.Style.default){ action in
                    let request2 = StyleReportRequest(reason: "음란물 및 성적 불쾌감", styleshotIdx: self.styleShotIdx)
                    StyleDetailDataManager().reportStyleDetail(request2, self)
                }
                reason2Action.setValue(UIColor.coGreen, forKey: "titleTextColor")
                let reason3Action = UIAlertAction(title: "사기 및 거짓 정보", style: UIAlertAction.Style.default){ action in
                    let request3 = StyleReportRequest(reason: "사기 및 거짓 정보", styleshotIdx: self.styleShotIdx)
                    StyleDetailDataManager().reportStyleDetail(request3, self)
                }
                reason3Action.setValue(UIColor.coGreen, forKey: "titleTextColor")
                let reason4Action = UIAlertAction(title: "상업적 광고", style: UIAlertAction.Style.default){ action in
                    let request4 = StyleReportRequest(reason: "상업적 광고", styleshotIdx: self.styleShotIdx)
                    StyleDetailDataManager().reportStyleDetail(request4, self)
                }
                reason4Action.setValue(UIColor.coGreen, forKey: "titleTextColor")
                let reason5Action = UIAlertAction(title: "지적재산권 및 저작권 침해", style: UIAlertAction.Style.default){ action in
                    let request5 = StyleReportRequest(reason: "지적재산권 및 저작권 침해", styleshotIdx: self.styleShotIdx)
                    StyleDetailDataManager().reportStyleDetail(request5, self)
                }
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
    
    
    @IBAction func toProductUrl(_ sender: Any) {
        let serviceSafriView: SFSafariViewController = SFSafariViewController(url: url! as URL)
        self.present(serviceSafriView, animated: true, completion: nil)
    }
    
    
    @IBAction func likeBtn(_ sender: Any) {
        let likeRequest = LikeRequest(styleshotIdx: styleShotIdx)
        
        if StyleDetailData?.isLike == 1{
            heartBtn.setImage(UIImage(named: "icHeartUnclick1"), for: .normal)
            let dislikeRequest = disLikeRequest(status: "N")
            StyleDetailDataManager().disLikeStyle(dislikeRequest, self, styleshotIdx: styleShotIdx)
            var cnt = StyleDetailData?.likeCnt ?? 0
            cnt = cnt - 1
            heartNum.text = "\(cnt)"
        }else{
            heartBtn.setImage(UIImage(named: "icHeartClick1"), for: .normal)
            StyleDetailDataManager().likeStyle(likeRequest, self)
            var cnt = StyleDetailData?.likeCnt ?? 0
            cnt = cnt + 1
            heartNum.text = "\(cnt)"
        }
    }
    
    
}

extension StyleDetailVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCV{
            return StyleDetailData?.category.count ?? 0
        }else{
            return StyleDetailData?.hashtag.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCVC", for: indexPath)as? TagCVC else {return UICollectionViewCell()}
        if collectionView == categoryCV{
            cell.categoryLabel.text = StyleDetailData?.category[indexPath.row]
            cell.categoryLabel.setLabelConfigure(label: cell.categoryLabel, styleShotCategoryType: StyleDetailData?.category[indexPath.row] ?? "")
        }else{
            cell.categoryLabel.text = "#" + (StyleDetailData?.hashtag[indexPath.row])!
            cell.backgroundColor = UIColor.backGround1
            cell.categoryLabel.textColor = UIColor.coGreen70
            cell.categoryLabel.font = UIFont.init(name: "AppleSDGothicNeo-Medium", size: 14)
            cell.cornerRadius = 8
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCV{
            var size = StyleDetailData?.category[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]).width ?? 0
            let entireSize = size + 12
            return CGSize(width: entireSize, height: 25)
        }else{
            var size2 = StyleDetailData?.hashtag[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width ?? 0
            let entireSize2 = size2 + 16
            return CGSize(width: entireSize2, height: 28)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == categoryCV{
            return 4
        }else{
            return 8
        }
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
        
        if StyleDetailData?.isLike == 1{
            heartBtn.setImage(UIImage(named: "icHeartClick1"), for: .normal)
        }else{
            heartBtn.setImage(UIImage(named: "icHeartUnclick1"), for: .normal)
        }
        
        self.productDetail.text = StyleDetailData?.resultDescription
        self.urlProduct.text = StyleDetailData?.productName
        
        if StyleDetailData!.productURL != ""{
            self.url = NSURL(string: StyleDetailData!.productURL ?? "")
        }else{
            moveUrl.text = "아이코가 url을 등록하지 않았습니다."
            moveUrlBtn.isHidden = true
        }
        
        print(StyleDetailData!.productURL)
        
        
        categoryCV.delegate = self
        categoryCV.dataSource = self
        categoryCV.reloadData()
        
        hashtagCV.delegate = self
        hashtagCV.dataSource = self
        hashtagCV.reloadData()
        
        
    }
    
    func didSuccessReport(message: String){
        if message == "성공"{
            self.presentAlert(title: "신고 접수가 완료되었습니다.")
        }
    }
    
    func didSuccessDelete(message: String){
        
    }
    
    func didSuccessLikeStyle(message: String){
        
    }
    
    func didSuccessDisLikeStyle(message: String){
        
    }
}
