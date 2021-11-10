//
//  ResultSortCVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

class ResultSortCVC: UICollectionViewCell {
    static let identifier = "ResultSortCVC"
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewConfigure()
    }

}
// MARK: - CollectionView Configure
extension ResultSortCVC {
    func collectionViewConfigure(){
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: SortCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: SortCVC.identifier)
        
    }
}
extension ResultSortCVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SortCVC.identifier, for: indexPath) as! SortCVC
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
      
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 28)
    }
    
}
