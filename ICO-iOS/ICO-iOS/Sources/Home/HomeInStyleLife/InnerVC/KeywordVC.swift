//
//  KeywordVC.swift
//  ICO
//
//  Created by 이은영 on 2021/11/03.
//

import UIKit

class KeywordVC: UIViewController {
    
    @IBOutlet weak var keywordCV: UICollectionView!
    @IBOutlet weak var postTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setCV()
       registerXib()
       //setUI()
    }

    func setCV(){
        keywordCV.delegate = self
        keywordCV.dataSource = self
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

    /*
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath)as? KeywordCVC{
            cell.colorView.setGradient(color1: UIColor.gradient01, color2: UIColor.gradient012)
            cell.keywordTitle.textColor = UIColor.white
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath)as? KeywordCVC{
            cell.colorView.backgroundColor = UIColor.clear
        }
    }*/
    
    
}
    
extension KeywordVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentTVC", for: indexPath)as? RecentTVC else {return UITableViewCell()}
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 616
    }
}
