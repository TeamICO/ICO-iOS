//
//  KeywordVC.swift
//  ICO
//
//  Created by 이은영 on 2021/11/03.
//

import UIKit

class KeywordVC: UIViewController {
    
    var keywordServerData: [RecentResult] = []
    var sortedIdx: Int = 1
    @IBOutlet weak var keywordCV: UICollectionView!
    @IBOutlet weak var postTV: UITableView!
    @IBOutlet weak var entireHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerXib()
        keywordCV.delegate = self
        keywordCV.dataSource = self
       //setUI()
    }

    func setCVTV(){
        postTV.delegate = self
        postTV.dataSource = self
    }
    
    func registerXib(){
        keywordCV.register(UINib(nibName: "KeywordCVC", bundle: nil), forCellWithReuseIdentifier: "KeywordCVC")
        postTV.register(UINib(nibName: "RecentTVC", bundle: nil), forCellReuseIdentifier: "RecentTVC")
    }
    

}


extension KeywordVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let keywordCell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordCVC", for: indexPath)as? KeywordCVC else {return UICollectionViewCell()}
        
        keywordCell.delegate = self
        keywordCell.sortedIdx = indexPath.row
        
        if indexPath.row == 0{
            keywordCell.keywordImg.image = UIImage(named: "illust-styleshot-vegan")
            keywordCell.colorView.backgroundColor = UIColor.lightSuccess
            keywordCell.keywordTitle.textColor = UIColor.alertsSuccess
            keywordCell.keywordTitle.text = "비건"
        }else if indexPath.row == 1{
            keywordCell.keywordImg.image = UIImage(named: "illust-styleshot-upcycling")
            keywordCell.colorView.backgroundColor = UIColor.coGreen5
            keywordCell.keywordTitle.textColor = UIColor.upcyclingGreen
            keywordCell.keywordTitle.text = "업사이클링"
        }else if indexPath.row == 2{
            keywordCell.keywordImg.image = UIImage(named: "illust-product-package")
            keywordCell.colorView.backgroundColor = UIColor.lightWarning
            keywordCell.keywordTitle.textColor = UIColor.alertWarning
            keywordCell.keywordTitle.text = "제로웨이스트"
        }else if indexPath.row == 3{
            keywordCell.keywordImg.image = UIImage(named: "illust-styleshot-value")
            keywordCell.colorView.backgroundColor = UIColor.lightPoint
            keywordCell.keywordTitle.textColor = UIColor.point
            keywordCell.keywordTitle.text = "가치"
        }else if indexPath.row == 4{
            keywordCell.keywordImg.image = UIImage(named: "illust-styleshot-organic")
            keywordCell.colorView.backgroundColor = UIColor.lightError
            keywordCell.keywordTitle.textColor = UIColor.alertsError
            keywordCell.keywordTitle.text = "유기농"
        }else if indexPath.row == 5{
            keywordCell.keywordImg.image = UIImage(named: "illust-styleshot-cleanbeauty")
            keywordCell.colorView.backgroundColor = UIColor.lightShadow
            keywordCell.keywordTitle.textColor = UIColor.coGreen
            keywordCell.keywordTitle.text = "클린뷰티"
        }else {
            keywordCell.keywordImg.image = UIImage(named: "illust-styleshot-energy")
            keywordCell.colorView.backgroundColor = UIColor.lightInfo
            keywordCell.keywordTitle.textColor = UIColor.alertsInfo
            keywordCell.keywordTitle.text = "에너지절약"
        }
        keywordCell.colorView.cornerRadius = 12
        
        return keywordCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = 32
        var width = 0
        
        if indexPath.row == 0 || indexPath.row == 3{
           width = 69
        }else if indexPath.row == 1 || indexPath.row == 6{
           width = 105
        }else if indexPath.row == 2{
            width = 118
        }else if indexPath.row == 4{
            width = 85
        }else{
            width = 100
        }
        
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        StyleLifeDataManager().getKeywordInfo(self, indexPath.row+1)
        for i in 0...6{
           let keywordCell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordCVC", for: indexPath)as? KeywordCVC
            if keywordCell?.isSelected == false{
                postTV.isHidden = true
                //hidden.isHidden = false
            }else{
                postTV.isHidden = false
                //hidden.isHidden = true
            }
        }
        
    }

    /*
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        var cell = collectionView.cellForItem(at: indexPath)as? KeywordCVC
        if ((cell?.isSelected) != nil){
            cell?.colorView.backgroundColor = UIColor.coGreen70
            cell?.keywordTitle.textColor = UIColor.white
        }
        //print(cell?.isSelected)
        
    }
     */
    /*
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath)as? KeywordCVC{
            cell.colorView.backgroundColor = UIColor.clear
        }
    }*/
    
    
}
    
extension KeywordVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keywordServerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentTVC", for: indexPath)as? RecentTVC else {return UITableViewCell()}
       
        cell.selectionStyle = .none
        cell.mainImage.setImage(with: keywordServerData[indexPath.row].imageURL)
        cell.nameLabel.text = keywordServerData[indexPath.row].nickname
        cell.userImage.setImage(with: keywordServerData[indexPath.row].profileURL)
        cell.detailLabel.text = keywordServerData[indexPath.row].resultDescription
        cell.heartNum.text = "\(keywordServerData[indexPath.row].likeCnt)"
        cell.productName.text = keywordServerData[indexPath.row].productName
        cell.score.text = "\(keywordServerData[indexPath.row].point)"
        if cell.score.text == "5"{
            cell.ecoLevelImg.image = UIImage(named: "ic-styleshot-upload-ecolevel-5")
        }else if cell.score.text == "4"{
            cell.ecoLevelImg.image = UIImage(named: "ic-styleshot-upload-ecolevel-4")
        }else if cell.score.text == "3"{
            cell.ecoLevelImg.image = UIImage(named: "ic-styleshot-upload-ecolevel-3")
        }else if cell.score.text == "2"{
            cell.ecoLevelImg.image = UIImage(named: "ic-styleshot-upload-ecolevel-2")
        }else if cell.score.text == "1"{
            cell.ecoLevelImg.image = UIImage(named: "ic-styleshot-upload-ecolevel-1")
        }
        cell.time.text = keywordServerData[indexPath.row].time
        cell.setData(category: keywordServerData[indexPath.row].category)
        
        if keywordServerData[indexPath.row].isLike == 1{
            cell.heartBtn.setImage(UIImage(named: "icHeartClick1"), for: .normal)
        }else{
            cell.heartBtn.setImage(UIImage(named: "icHeartUnclick1"), for: .normal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let styleDetailSB = UIStoryboard(name: "StyleDetail", bundle: nil)
        let styleDetailVC = styleDetailSB.instantiateViewController(withIdentifier: "StyleDetailVC")as! StyleDetailVC
        styleDetailVC.isMine = false
        styleDetailVC.styleShotIdx = keywordServerData[indexPath.row].styleshotIdx
        self.navigationController?.pushViewController(styleDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 616
    }
}


extension KeywordVC{
    func didSuccessGetKeyword(message: String){
        let cnt :Int = keywordServerData.count
        entireHeight.constant = CGFloat(136 + (cnt * 616))
        setCVTV()
        postTV.reloadData()
        print(message)
    }
}


extension KeywordVC : KeywordCVCDelagate{
    func didTapSort(sortedIdx: Int) {
        self.sortedIdx = sortedIdx
    }
    
    
}
