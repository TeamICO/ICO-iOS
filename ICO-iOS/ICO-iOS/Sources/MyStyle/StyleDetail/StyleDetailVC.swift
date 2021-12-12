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
    
    @IBOutlet weak var topView: UIView!
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
    
    
    @IBOutlet weak var scrollView: UIScrollView!

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

        self.tabBarController?.tabBar.isHidden = true
        StyleDetailDataManager().getStyleDetail(self, styleShotIdx: styleShotIdx)
        setUI()
        categoryCV.register(UINib(nibName: "TagCVC", bundle: nil), forCellWithReuseIdentifier: "TagCVC")
        hashtagCV.register(UINib(nibName: "TagCVC", bundle: nil), forCellWithReuseIdentifier: "TagCVC")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toDetailProfile))
        userImage.addGestureRecognizer(tapGesture)
        userImage.isUserInteractionEnabled =  true
        
        setUpGesture()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setBlurEffect(view: topView)
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
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if isMine == true{
            let fixAction = UIAlertAction(title: "스타일 수정", style: UIAlertAction.Style.default){ [self] action in
                let uploadSB = UIStoryboard(name: "StyleUpload", bundle: nil)
                let uploadVC = uploadSB.instantiateViewController(withIdentifier: "StyleUploadVC")as? StyleUploadVC
                uploadVC?.isFix = true
                uploadVC?.styleIndex = self.styleShotIdx
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
                
                alertController.popoverPresentationController?.sourceView = self.view
                
                if UIDevice.current.userInterfaceIdiom == .pad { //디바이스 타입이 iPad일때
                  
                      // ActionSheet가 표현되는 위치를 저장해줍니다.

                     
                    alertController.popoverPresentationController?.sourceRect =  CGRect(x: self.view.bounds.midX, y: self.view.bottom, width: 0, height: 0)
                    alertController.popoverPresentationController?.permittedArrowDirections = []
                      self.present(alertController, animated: true, completion: nil)
                  
                } else {
                    alertController.popoverPresentationController?.sourceRect = self.view.bounds
                  self.present(alertController, animated: true, completion: nil)
                }
            }
            reportAction.setValue(UIColor.alertsError, forKey: "titleTextColor")
            
            let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
            cancelAction.setValue(UIColor.primaryBlack70, forKey: "titleTextColor")
            
            alert.addAction(reportAction)
            alert.addAction(cancelAction)
        }
        alert.popoverPresentationController?.sourceView = view
        
        if UIDevice.current.userInterfaceIdiom == .pad { //디바이스 타입이 iPad일때
          
              // ActionSheet가 표현되는 위치를 저장해줍니다.

             
            alert.popoverPresentationController?.sourceRect =  CGRect(x: self.view.bounds.midX, y: self.view.bottom, width: 0, height: 0)
            alert.popoverPresentationController?.permittedArrowDirections = []
              self.present(alert, animated: true, completion: nil)
          
        } else {
            alert.popoverPresentationController?.sourceRect = view.bounds
          self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func viewDidTap(_ sender: UITapGestureRecognizer){
        if let mainurl = url{
            let serviceSafriView: SFSafariViewController = SFSafariViewController(url: mainurl as! URL)
            let SB = UIStoryboard(name: "LifeStyleURL", bundle: nil)
            let vc = SB.instantiateViewController(withIdentifier: "LifeStyleURLVC") as! LifeStyleURLVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            self.dismiss(animated: true){
                self.present(serviceSafriView, animated: true, completion: nil)
            }
           
        }else{
            urlBackView.isUserInteractionEnabled = false
        }
    }
    
    func setUpGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap(_:)))
        urlBackView.addGestureRecognizer(tapGesture)
        urlBackView.isUserInteractionEnabled = true
    }
    
    @objc func toDetailProfile(){
        let profileSB = UIStoryboard(name: "PopularIco", bundle: nil)
        let profileVC = profileSB.instantiateViewController(withIdentifier: "PopularIco")as! PopularIcoVC
        guard let ID = StyleDetailData?.userIdx else{
            return
        }
        profileVC.id = ID
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @IBAction func likeBtn(_ sender: Any) {


        if let isLike = StyleDetailData?.isLike,
           var likeCnt = StyleDetailData?.likeCnt{
            if isLike == 1{
                let dislikeRequest = disLikeRequest(status: "N")
                StyleDetailDataManager().disLikeStyle(dislikeRequest, styleshotIdx: styleShotIdx) { response in
                    guard response else{
                        return
                    }
                    StyleDetailDataManager().getStyleDetail(styleShotIdx: self.styleShotIdx) { result in
                        guard let result = result else{
                            return
                        }
                        self.StyleDetailData = result
                        DispatchQueue.main.async {
                            self.heartBtn.setImage(UIImage(named: "icHeartUnclick1"), for: .normal)
                            likeCnt -=  1
                            self.heartNum.text = "\(likeCnt)"
                            self.didSuccessStyleDetail(message: nil)
                        }
                    }
                  
                }
            }else if isLike == 0 {
                StyleDetailDataManager().likeStyle(self.styleShotIdx){ response in
                    guard response else{
                        return
                    }
                    StyleDetailDataManager().getStyleDetail(styleShotIdx: self.styleShotIdx) { result in
                        guard let result = result else{
                            return
                        }
                        self.StyleDetailData = result
                        DispatchQueue.main.async {
                            self.heartBtn.setImage(UIImage(named: "icHeartClick1"), for: .normal)
                            likeCnt += 1
                            self.heartNum.text = "\(likeCnt)"
                            self.didSuccessStyleDetail(message: nil)
                        }
                    }
                }
             
            }
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
    func didSuccessStyleDetail(message: String?){
        self.productImage.setImage(with: StyleDetailData?.imageURL ?? "")
        self.userImage.setImage(with: StyleDetailData?.profileURL ?? "")
        if StyleDetailData?.profileURL == ""{
            self.userImage.image = UIImage(named: "img_profile_default")
        }
        self.userName.text = StyleDetailData?.nickname
        self.productName.text = StyleDetailData?.productName
        self.heartNum.text = "\(StyleDetailData?.likeCnt ?? 0)"
        let score1 = StyleDetailData?.point ?? 0
        self.scoreNum.text = "\(score1).0"
        if scoreNum.text == "5.0"{
           ecoLevelImg.image = UIImage(named: "ic-styleshot-upload-ecolevel-5")
        }else if scoreNum.text == "4.0"{
           ecoLevelImg.image = UIImage(named: "ic-styleshot-upload-ecolevel-4")
        }else if scoreNum.text == "3.0"{
           ecoLevelImg.image = UIImage(named: "ic-styleshot-upload-ecolevel-3")
        }else if scoreNum.text == "2.0"{
           ecoLevelImg.image = UIImage(named: "ic-styleshot-upload-ecolevel-2")
        }else if scoreNum.text == "1.0"{
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
        
        if StyleDetailData?.isMe == 1{
            isMine = true
        }else{
            isMine = false
        }

        categoryCV.delegate = self
        categoryCV.dataSource = self

        hashtagCV.delegate = self
        hashtagCV.dataSource = self
    }
    
    func didSuccessReport(message: String){
        if message == "성공"{
            let SB = UIStoryboard(name: "CustomPopupSB", bundle: nil)
            let vc = SB.instantiateViewController(withIdentifier: "CustomPopupVC") as! CustomPopupVC
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            vc.text = "신고 접수가 완료되었습니다."
            self.present(vc, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5){
                vc.dismiss(animated: true) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func didSuccessDelete(message: String){
        
    }
    
    func didSuccessLikeStyle(message: String){
        
    }
    
    func didSuccessDisLikeStyle(message: String){
        
    }
}

