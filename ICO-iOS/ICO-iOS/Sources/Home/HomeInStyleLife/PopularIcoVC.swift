//
//  PopularIcoVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/09.
//

import UIKit

class PopularIcoVC: UIViewController {
    
    var serverData : MyStyleResult?
    var id: Int = 0
    
    @IBOutlet weak var entireHeight: NSLayoutConstraint!
    
    @IBOutlet weak var styleCV: UICollectionView!

    @IBOutlet weak var navigationTitle: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet var keywordView: [UIView]!
    @IBOutlet var keywordImage: [UIImageView]!
    @IBOutlet var keywordName: [UILabel]!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var profileline: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var likeNum: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var styleNum: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        StyleLifeDataManager().getPopularIcoInfo(self, userIdx: id)
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
        navigationTitle.text = "프로필"
        navigationTitle.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 20)
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
    
    @IBAction func toBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension PopularIcoVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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
        styleDetailVC.isMine = false
        styleDetailVC.styleShotIdx = serverData?.styleshot[indexPath.row].styleshotIdx ?? 0
        self.navigationController?.pushViewController(styleDetailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = 166
        let cellHeight = 166
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension PopularIcoVC{
    func didSuccessGetPopularIco(message: String){
        name.text = serverData?.nickname
        
        if serverData?.resultDescription == ""{
            detailLabel.text = "아직 프로필 한마디를 작성하지 않았습니다."
        }else{
            detailLabel.text = serverData?.resultDescription
        }
        
        if serverData?.profileURL == ""{
            profileImage.image = UIImage(named: "img_profile_default")
        }else{
           profileImage.setImage(with: serverData?.profileURL ?? "")
        }
    
        likeNum.text = "\(serverData?.likeCnt ?? 0)"
        styleNum.text = "\(serverData?.styleshotCnt ?? 0) "
        
        var item = (serverData?.styleshotCnt)!
        if item % 2 == 0 {
            entireHeight.constant = CGFloat(389 + 180*(item/2))
        }else{
            entireHeight.constant = CGFloat(389 + 180*((item+1)/2))
        }
        
        setCV()
        styleCV.reloadData()
        
    }
}
