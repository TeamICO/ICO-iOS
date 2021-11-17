//
//  MyStyleVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//

import UIKit

class MyStyleVC: BaseViewController {
    
    var serverData : MyStyleResult?
    
    @IBOutlet weak var styleCV: UICollectionView!
    @IBOutlet weak var navigationTitle: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var profileline: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet var keywordView: [UIView]!
    @IBOutlet var keywordName: [UILabel]!
    
    @IBOutlet weak var likeNum: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var styleNum: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        MyStyleDataManager().getMyStyleInfo(self, userIdx: 7)
        setUI()
        registerNib()
        // Do any additional setup after loading the view.
    }
    
    func setCV(){
        styleCV.delegate = self
        styleCV.dataSource = self
    }
    
    func registerNib(){
        styleCV.register(UINib(nibName: "StyleCVC", bundle: nil), forCellWithReuseIdentifier: "StyleCVC")
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
            
            keywordName[0].text = "업사이클링"
            keywordName[1].text = "수익기부"
            keywordName[2].text = "무향료"
            for i in 0...2{
                keywordView[i].backgroundColor = UIColor.primaryigreen5
                keywordView[i].cornerRadius = 8
                keywordName[i].textColor = UIColor.coGreen
            }
            
            likeLabel.text = "누적 좋아요"
            styleLabel.text = "누적 스타일 샷"
            likeNum.font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 24)
            likeLabel.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
            likeLabel.textColor = UIColor.primaryBlack60
            styleNum.font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 24)
            styleLabel.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
            styleLabel.textColor = UIColor.primaryBlack60
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
        return serverData?.styleshotCnt ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let styleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "StyleCVC", for: indexPath)as? StyleCVC else {return UICollectionViewCell()}
        
        styleCell.styleImage.setImage(with: serverData?.styleshot[indexPath.row].imageURL ?? "")
        
        return styleCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let styleDetailSB = UIStoryboard(name: "StyleDetail", bundle: nil)
        let styleDetailVC = styleDetailSB.instantiateViewController(withIdentifier: "StyleDetailVC")as! StyleDetailVC
        self.navigationController?.pushViewController(styleDetailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = 164
        let cellHeight = 164
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}


extension MyStyleVC{
    func didSuccessGetMyStyle(message: String){
        name.text = serverData?.nickname
        detailLabel.text = serverData?.resultDescription
        likeNum.text = "\(serverData?.likeCnt ?? 0)"
        styleNum.text = "\(serverData?.styleshotCnt ?? 0)"
        setCV()
        styleCV.reloadData()
        
        print(message)
    }

}
