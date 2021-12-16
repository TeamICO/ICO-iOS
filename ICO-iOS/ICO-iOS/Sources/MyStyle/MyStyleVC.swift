//
//  MyStyleVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//

import UIKit

class MyStyleVC: BaseViewController{
    
    var isStart = false
    
    var styleShotResult  = [StyleShotResult]()
    var serverData : UserInfoResult?
   // var styleshot = [Styleshot]()
    var category: [String] = []
    @IBOutlet weak var alarmView: UIView!
    @IBOutlet weak var alarmIcon: UIImageView!
    @IBOutlet weak var likeView: UIView!
    
    @IBOutlet weak var entireHeight: NSLayoutConstraint!
    @IBOutlet weak var styleCV: UICollectionView!
    @IBOutlet weak var navigationTitle: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var profileline: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var categoryCV: UICollectionView!
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var likeNum: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var styleNum: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var topView: UIView!
    
    
    @IBOutlet weak var myStyleScrollView: UIScrollView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkInternet()
        MyStyleDataManager().getMyStyleUser(self, userIdx: self.userIdx)
        alarmConfigure()
        fetchData()
        self.tabBarController?.tabBar.isHidden = false
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyStyleDataManager().getMyStyleUser(self, userIdx: self.userIdx)
        setUI()
        registerNib()
        setAlarmViewTapGesture()
        setLikeViewTapGesture()
        categoryCV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
        fetchData()
    
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setBlurEffect(view: topView)
    }
    func setCV(){
        styleCV.delegate = self
        styleCV.dataSource = self
        categoryCV.delegate = self
        categoryCV.dataSource = self
    }
    
    func registerNib(){
        styleCV.register(UINib(nibName: "StyleCVC", bundle: nil), forCellWithReuseIdentifier: "StyleCVC")
        categoryCV.register(UINib(nibName: "ecoKeywordCVC", bundle: nil), forCellWithReuseIdentifier: "ecoKeywordCVC")
        styleCV.register(UINib(nibName: "emptyStyleShotCVC", bundle: nil), forCellWithReuseIdentifier: "emptyStyleShotCVC")
    }
    
    func setUI(){
        navigationTitle.text = "나의 스타일"
        navigationTitle.font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 20)
 
        backView.backgroundColor = UIColor.lightShadow
        lineView.backgroundColor = UIColor.primaryBlack40
            
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowColor = UIColor.init(red: 0.288, green: 0.288, blue: 0.288, alpha: 0.1).cgColor
        shadowView.layer.shadowRadius = 13
        shadowView.layer.cornerRadius = 16
        shadowView.layer.shadowOffset = CGSize(width: 8, height: 8)
            
        profileImage.cornerRadius = 12
        name.font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 20)
        keywordLabel.text = "에코 관심 키워드"
        keywordLabel.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
        profileline.backgroundColor = UIColor.primaryBlack50
        detailLabel.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
            
        likeLabel.text = "누적 좋아요"
        styleLabel.text = "누적 스타일 샷"
        likeNum.font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 24)
        likeLabel.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
        likeLabel.textColor = UIColor.primaryBlack60
        styleNum.font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 24)
        styleLabel.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
        styleLabel.textColor = UIColor.primaryBlack60
        
        gradientView.setGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: UIColor.white)
    }
    
    
    @IBAction func toProfileSetting(_ sender: Any) {
        let SettingSB = UIStoryboard(name: "ProfileSetting", bundle: nil)
        
        guard let ProfileSettingVC = SettingSB.instantiateViewController(withIdentifier: "ProfileSetting")as? ProfileSettingVC else {return}
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(ProfileSettingVC, animated: true)
    }
    
    
    @IBAction func toStyleUpload(_ sender: Any) {
        let styleUploadSB = UIStoryboard(name: "StyleUpload", bundle: nil)
        guard let styleUploadVC = styleUploadSB.instantiateViewController(withIdentifier: "StyleUploadVC")as? StyleUploadVC else {return}
        self.navigationController?.pushViewController(styleUploadVC, animated: true)
    }
    
}

extension MyStyleVC{
    func fetchData(){
        
        MyStyleDataManager.shared.getMyStyleShot(pagination: false, lastIndex: 0, userIdx: userIdx, self){ [weak self] response in
            guard let response = response else {
                return
            }
            self?.styleShotResult = response
            self?.styleCV.reloadData()
            if response.isEmpty {
                self?.styleCV.isScrollEnabled = false
            }
            self?.isStart = true
        }
    }
    
    // 페이징
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffY = scrollView.contentOffset.y
        
        if contentOffY >= (styleCV.contentSize.height+150-scrollView.frame.size.height){
            guard isStart != nil else{
                return
            }
            guard !MyStyleDataManager.shared.isStyleShotPaginating else{
                return
            }
            
            MyStyleDataManager.shared.getMyStyleShot(pagination: true, lastIndex: self.styleShotResult.count, userIdx: userIdx, self){ [weak self] response in
                guard let response = response else{
                    return
                }
                self?.styleShotResult.append(contentsOf: response)
                self?.styleCV.reloadData()
            }
        }
    }

}

extension MyStyleVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == styleCV{
            return self.styleShotResult.count == 0 ? 1 : self.styleShotResult.count
        }else{
            return serverData?.ecoKeyword.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == styleCV{
            if self.styleShotResult.isEmpty {
                
                guard let styleEmptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyStyleShotCVC", for: indexPath)as? emptyStyleShotCVC else {
                    
                    return UICollectionViewCell()
                    
                }
                
                return styleEmptyCell
            }else {
                guard let styleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "StyleCVC", for: indexPath)as? StyleCVC else {return UICollectionViewCell()}
                /*
                if let styleshot = styleShotResult{
                    if !styleshot.isEmpty{
                        styleCell.styleImage.setImage(with: styleshot[indexPath.row].imageURL)
                    }
                }*/
                if !styleShotResult.isEmpty{
                    styleCell.styleImage.setImage(with: styleShotResult[indexPath.row].imageURL)
                }
                return styleCell
            }
        }else if collectionView == categoryCV{
            if serverData?.ecoKeyword.count != 0{
                guard let ecoKeywordCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ecoKeywordCVC", for: indexPath)as? ecoKeywordCVC else {return UICollectionViewCell()}
                
                ecoKeywordCell.ecoTitle.text = serverData?.ecoKeyword[indexPath.row]
                if serverData?.ecoKeyword[indexPath.row] == "수익기부"{
                  ecoKeywordCell.ecoIcon.image = UIImage(named: "illust-product-donation")
                }else if serverData?.ecoKeyword[indexPath.row] == "동물실험 반대"{
                  ecoKeywordCell.ecoIcon.image = UIImage(named: "illust-product-animal")
                }else if serverData?.ecoKeyword[indexPath.row] == "공정무역"{
                    ecoKeywordCell.ecoIcon.image = UIImage(named: "illust-product-trade")
                }else if serverData?.ecoKeyword[indexPath.row] == "비건"{
                    ecoKeywordCell.ecoIcon.image = UIImage(named: "illust-product-vegan")
                }else if serverData?.ecoKeyword[indexPath.row] == "락토"{
                    ecoKeywordCell.ecoIcon.image = UIImage(named: "illust-product-lacto")
                }else if serverData?.ecoKeyword[indexPath.row] == "락토오보"{
                    ecoKeywordCell.ecoIcon.image = UIImage(named: "illust-product-lactovo")
                }else if serverData?.ecoKeyword[indexPath.row] == "페스코"{
                    ecoKeywordCell.ecoIcon.image = UIImage(named: "illust-product-fesco")
                }else if serverData?.ecoKeyword[indexPath.row] == "플라스틱 프리"{
                    ecoKeywordCell.ecoIcon.image = UIImage(named: "illust-product-plastic")
                }else if serverData?.ecoKeyword[indexPath.row] == "친환경"{
                    ecoKeywordCell.ecoIcon.image = UIImage(named: "illust-product-eco")
                }else if serverData?.ecoKeyword[indexPath.row] == "업사이클링"{
                    ecoKeywordCell.ecoIcon.image = UIImage(named: "illust-product-upcycling")
                }else if serverData?.ecoKeyword[indexPath.row] == "비건을 위한 뷰티"{
                    ecoKeywordCell.ecoIcon.image = UIImage(named: "illust-product-package")
                }else if serverData?.ecoKeyword[indexPath.row] == "GMO프리"{
                    ecoKeywordCell.ecoIcon.image = UIImage(named: "illust-product-gmo")
                }else if serverData?.ecoKeyword[indexPath.row] == "무향료"{
                    ecoKeywordCell.ecoIcon.image = UIImage(named: "illust-product-chemical")
                }else if serverData?.ecoKeyword[indexPath.row] == "FDA 승인"{
                    ecoKeywordCell.ecoIcon.image = UIImage(named: "illust-product-fda")
                }
                
                return ecoKeywordCell
            }else{
                guard let emptyEcoKeywordCell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyEcoKeywordCVC", for: indexPath)as?emptyEcoKeywordCVC else {return UICollectionViewCell()}
                
                emptyEcoKeywordCell.emptyLabel.text = "에코 관심 키워드를 등록하지 않았습니다."
                
                return emptyEcoKeywordCell
            }
            

        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == styleCV {
            if self.styleShotResult.count != 0{
                let styleDetailSB = UIStoryboard(name: "StyleDetail", bundle: nil)
                let styleDetailVC = styleDetailSB.instantiateViewController(withIdentifier: "StyleDetailVC")as! StyleDetailVC
                styleDetailVC.isMine = true
                styleDetailVC.styleShotIdx = styleShotResult[indexPath.row].styleshotIdx ?? 0
                self.navigationController?.pushViewController(styleDetailVC, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == styleCV{
            if styleShotResult.count != 0 {
                let cellWidth = 166
                let cellHeight = 166
                
                return CGSize(width: cellWidth, height: cellHeight)
            }else{
                let cellWidth2 = 414
                let cellHeight2 = 700
                
                return CGSize(width: cellWidth2, height: cellHeight2)
            }
        }else{
            if serverData?.ecoKeyword.count != 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ecoKeywordCVC", for: indexPath) as! ecoKeywordCVC
                var size = serverData?.ecoKeyword[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]).width ?? 0
                let totalWidth = size + cell.ecoIcon.frame.size.width + 16
                return CGSize(width: totalWidth, height: 25)
            }else{
                let cellWidth = 237
                let cellHeight = 17
                
                return CGSize(width: cellWidth, height: cellHeight)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == styleCV{
            return 16
        }else{
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == styleCV{
            return 8
        }else{
            return 4
        }
    
    }
}


extension MyStyleVC{
    func didSuccessGetMyStyleUser(message: String){
        name.text = serverData?.nickname
        
        if serverData?.profileURL == ""{
            profileImage.image = UIImage(named: "img_profile_default")
        }else{
            profileImage.setImage(with: serverData?.profileURL ?? "")
        }
        
        if serverData?.resultDescription == ""{
            detailLabel.text = "아직 프로필 한마디를 작성하지 않았습니다"
            detailLabel.textColor = UIColor.primaryBlack40
        }else{
            detailLabel.text = serverData?.resultDescription
            detailLabel.textColor = UIColor.primaryBlack80
        }
        likeNum.text = "\(serverData?.likeCnt ?? 0)"
        styleNum.text = "\(serverData?.styleshotCnt ?? 0)"
        //389
        var item = (serverData?.styleshotCnt)!
    
        
        if item % 2 == 0 {
            entireHeight.constant = CGFloat(500 + 180*(item/2))
            if item == 0 {
                entireHeight.constant = CGFloat(800)
            }
        }else{
            entireHeight.constant = CGFloat(500 + 180*((item+1)/2))
        }
        setCV()
        styleCV.reloadData()
    }

}
//MARK : 좋아요 뷰
extension MyStyleVC {
    
    func setLikeViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapLikeView))
        viewTap.cancelsTouchesInView = false
        likeView.addGestureRecognizer(viewTap)
    }
    @objc func didTapLikeView(){
        
        self.navigationPushViewController(storyboard: "LikeSB", identifier: "LikeVC")
    }
}

//MARK : 알림 뷰
extension MyStyleVC {
    func setAlarmViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapAlarmView))
        viewTap.cancelsTouchesInView = false
        alarmView.addGestureRecognizer(viewTap)
    }
    @objc func didTapAlarmView(){
    
        self.navigationPushViewController(storyboard: "AlarmSB", identifier: "AlarmVC")
    }
    func alarmConfigure(){
        guard let jwtToken = self.jwtToken else{
            return
        }
        BaseManager.shared.getUserNewAlarm(jwtToken: jwtToken) { response in
            guard let response = response else {
                return
            }
            self.alarmIcon.image = response == 0 ? UIImage(named: "icAlram1") : UIImage(named: "icAlarmOn1")
                
            
        }
    }
}
