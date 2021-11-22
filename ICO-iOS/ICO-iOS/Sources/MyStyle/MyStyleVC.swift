//
//  MyStyleVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//

import UIKit

class MyStyleVC: BaseViewController {
    
    var serverData : MyStyleResult?
    var category: [String] = []
    @IBOutlet weak var alarmView: UIView!
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MyStyleDataManager().getMyStyleInfo(self, userIdx: self.userIdx)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MyStyleDataManager().getMyStyleInfo(self, userIdx: self.userIdx)
        setUI()
        registerNib()
        // Do any additional setup after loading the view.
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
        detailLabel.textColor = UIColor.primaryBlack60
            
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

extension MyStyleVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == styleCV{
            return serverData?.styleshotCnt ?? 0
        }else{
            return serverData?.ecoKeyword.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == styleCV{
            guard let styleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "StyleCVC", for: indexPath)as? StyleCVC else {return UICollectionViewCell()}
            if let styleshot = serverData?.styleshot{
                if !styleshot.isEmpty{
                    styleCell.styleImage.setImage(with: styleshot[indexPath.row].imageURL)
                }
                
            }
            
            
            return styleCell
        }else{
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
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let styleDetailSB = UIStoryboard(name: "StyleDetail", bundle: nil)
        let styleDetailVC = styleDetailSB.instantiateViewController(withIdentifier: "StyleDetailVC")as! StyleDetailVC
        styleDetailVC.isMine = true
        styleDetailVC.styleShotIdx = serverData?.styleshot[indexPath.row].styleshotIdx ?? 0
        self.navigationController?.pushViewController(styleDetailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == styleCV{
            let cellWidth = 166
            let cellHeight = 166
            
            return CGSize(width: cellWidth, height: cellHeight)
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ecoKeywordCVC", for: indexPath) as! ecoKeywordCVC
            var size = serverData?.ecoKeyword[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]).width ?? 0
            let totalWidth = size + cell.ecoIcon.frame.size.width + 16
            return CGSize(width: totalWidth, height: 25)
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
    func didSuccessGetMyStyle(message: String){
        name.text = serverData?.nickname
        profileImage.setImage(with: serverData?.profileURL ?? "")
        detailLabel.text = serverData?.resultDescription
        likeNum.text = "\(serverData?.likeCnt ?? 0)"
        styleNum.text = "\(serverData?.styleshotCnt ?? 0)"
        //389
        var item = (serverData?.styleshotCnt)!
        if item % 2 == 0 {
            entireHeight.constant = CGFloat(500 + 180*(item/2))
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
}
