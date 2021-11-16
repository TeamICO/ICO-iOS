//
//  MypageMyRecentStyleShotTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

class MypageMyRecentStyleShotTVC: UITableViewCell {
    static let identifier = "MypageMyRecentStyleShotTVC"
    
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
        
    }
}
extension MypageMyRecentStyleShotTVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPageStyleshotModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MypageMyRecentStyleShotCVC.identifier, for: indexPath) as! MypageMyRecentStyleShotCVC
        cell.setImage(url: myPageStyleshotModel[indexPath.row].imageURL)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
      
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
}
