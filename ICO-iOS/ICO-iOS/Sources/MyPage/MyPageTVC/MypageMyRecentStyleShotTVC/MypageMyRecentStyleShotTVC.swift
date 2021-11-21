//
//  MypageMyRecentStyleShotTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit
protocol MypageMyRecentStyleShotTVCDelegate : AnyObject{
    func didTapEachCells(styleShotIdx : Int)
}


class MypageMyRecentStyleShotTVC: UITableViewCell {
    static let identifier = "MypageMyRecentStyleShotTVC"
    
    weak var delegate : MypageMyRecentStyleShotTVCDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var myPageStyleshotModel = [MyPageStyleshot]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewConfigure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func getData(data : [MyPageStyleshot]){
        self.myPageStyleshotModel = data
        collectionView.reloadData()
    }
    
}
// MARK: - CollectionView Configure
extension MypageMyRecentStyleShotTVC {
    func collectionViewConfigure(){
        
       collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: MypageMyRecentStyleShotCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: MypageMyRecentStyleShotCVC.identifier)
        let nonenib = UINib(nibName: MypageNoneMyRecentStyleShotCVC.identifier, bundle: nil)
        collectionView.register(nonenib, forCellWithReuseIdentifier: MypageNoneMyRecentStyleShotCVC.identifier)
    }
}
extension MypageMyRecentStyleShotTVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !myPageStyleshotModel.isEmpty{
            return myPageStyleshotModel.count
        }else{
            return 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !myPageStyleshotModel.isEmpty{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MypageMyRecentStyleShotCVC.identifier, for: indexPath) as! MypageMyRecentStyleShotCVC
            cell.setImage(url: myPageStyleshotModel[indexPath.row].imageURL)
            return cell
           
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MypageNoneMyRecentStyleShotCVC.identifier, for: indexPath) as! MypageNoneMyRecentStyleShotCVC
            
            return cell
        }

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !myPageStyleshotModel.isEmpty{
            collectionView.deselectItem(at: indexPath, animated: true)
            delegate?.didTapEachCells(styleShotIdx: myPageStyleshotModel[indexPath.row].styleshotIdx)
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if !myPageStyleshotModel.isEmpty{
           
            return CGSize(width: 100, height: 100)
           
        }else{
            
            return CGSize(width: self.width-32, height: 100)
        }
      
    }
    
}
