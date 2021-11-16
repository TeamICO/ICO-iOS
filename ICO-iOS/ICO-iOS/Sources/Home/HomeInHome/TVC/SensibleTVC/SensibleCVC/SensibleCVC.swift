//
//  SensibleCVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/07.
//

import UIKit

class SensibleCVC: UICollectionViewCell {
    static let identifier = "SensibleCVC"
    
    let cartegoryModels = ["유기농", "클린뷰티"]
    let cartegoryFontColors : [UIColor] = [UIColor.appColor(.categoryFontRed),UIColor.appColor(.categoryFontGreen)]
    let cartegoryBackColors : [UIColor] = [UIColor.appColor(.categoryBackgroundRed),UIColor.appColor(.categoryBackgroundGreen)]
    
    @IBOutlet weak var userStyleShotImage: UIImageView!
    @IBOutlet weak var styleShotImage: UIImageView!
    
    @IBOutlet weak var userId: UILabel!
    

    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK : Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        gradientView.setGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: .white)
        
        collectionViewConfigure()
    }
 
  
    
}
// MARK: - CollectionView Configure
extension SensibleCVC {
    func collectionViewConfigure(){

        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: SensibleCollectionViewCellCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: SensibleCollectionViewCellCVC.identifier)
        
    }
}
extension SensibleCVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SensibleCollectionViewCellCVC.identifier, for: indexPath) as! SensibleCollectionViewCellCVC
        cell.categoryLabel.text = cartegoryModels[indexPath.row]
        cell.categoryLabel.backgroundColor = cartegoryBackColors[indexPath.row]
        cell.categoryLabel.textColor = cartegoryFontColors[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cartegoryModels[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]).width + 12, height: 25)
    }
    
}
