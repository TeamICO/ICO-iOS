//
//  KeywordVC.swift
//  ICO
//
//  Created by 이은영 on 2021/11/03.
//

import UIKit
import SwiftUI

class KeywordVC: UIViewController {
    
    @IBOutlet weak var keywordCV: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

       setCV()
       registerXib()
    }

    func setCV(){
        keywordCV.delegate = self
        keywordCV.dataSource = self
    }
    
    func registerXib(){
        keywordCV.register(UINib(nibName: "KeywordCVC", bundle: nil), forCellWithReuseIdentifier: "KeywordCVC")
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
            keywordCell.colorView.backgroundColor = UIColor.lightSuccess
            keywordCell.keywordTitle.textColor = UIColor.coGreen60
            keywordCell.keywordTitle.text = "업사이클링"
        }else if indexPath.row == 2{
            keywordCell.keywordImg.image = UIImage(named: "illust-product-package")
            keywordCell.colorView.backgroundColor = UIColor.lightWarning
            keywordCell.keywordTitle.textColor = UIColor.alertWarning
            keywordCell.keywordTitle.text = "제로웨이스트"
        }else if indexPath.row == 3{
            keywordCell.keywordImg.image = UIImage(named: "illust-styleshot-value")
            keywordCell.colorView.backgroundColor = UIColor.lightWarning
            keywordCell.keywordTitle.textColor = UIColor.alertWarning
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
        
        return keywordCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 32
        var width = 0
        
        if indexPath.row == 0 && indexPath.row == 3{
           width = 69
        }else if indexPath.row == 1 && indexPath.row == 6{
           width = 105
        }else if indexPath.row == 2{
            width = 118
        }else if indexPath.row == 4{
            width = 100
        }else{
            width = 100
        }
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
}
