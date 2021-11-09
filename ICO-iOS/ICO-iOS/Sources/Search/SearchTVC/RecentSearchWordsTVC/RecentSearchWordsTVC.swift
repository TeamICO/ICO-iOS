//
//  RecentSearchWordsTVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/07.
//

import UIKit

class RecentSearchWordsTVC: UITableViewCell {
    static let identifier = "RecentSearchWordsTVC"
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewConfigure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    @IBAction func didTapDeleteAllButton(_ sender: Any) {
    }
}
// MARK: - CollectionView Configure
extension RecentSearchWordsTVC {
    func collectionViewConfigure(){
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: RecentCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: RecentCVC.identifier)
        
    }
}
extension RecentSearchWordsTVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCVC.identifier, for: indexPath) as! RecentCVC
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
      
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 28)
    }
    
}
