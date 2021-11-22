//
//  LikeCVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/11.
//

import UIKit

class LikeCVC: UICollectionViewCell {
    static let identifier = "LikeCVC"
    
    var category = [String]()
    private var styleshotIdx = 0
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var gradientView: UIView!
    
    
    
    // MARK : Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        gradientView.setGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: .white)
        collectionViewConfigure()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.userImage.image = nil
        self.contentImage.image = nil
        self.userNameLabel.text = nil
    }
    func getData(data : [String]){
        self.category = data
        
        collectionView.reloadData()
    }
   
}
// MARK: - CollectionView Configure
extension LikeCVC {
    func collectionViewConfigure(){
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: EcoTopicCollectionViewCellCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: EcoTopicCollectionViewCellCVC.identifier)
        
    }
    func configure(with viewModel : LikeCVCViewModel){
        self.userNameLabel.text = viewModel.nickName
        self.styleshotIdx = viewModel.styleshotIdx
        self.contentImage.setImage(with: viewModel.userContentImage)
        self.userImage.setImage(with: viewModel.userImage)
      
        
        
    }

}
extension LikeCVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EcoTopicCollectionViewCellCVC.identifier, for: indexPath) as! EcoTopicCollectionViewCellCVC
        cell.categoryLabel.text = category[indexPath.row]
        cell.categoryLabel.setLabelConfigure(label: cell.categoryLabel, styleShotCategoryType: category[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: category[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]).width + 12, height: 25)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}
struct LikeCVCViewModel {
    let userContentImage : String
    let userImage : String
    let nickName : String
    let styleshotIdx : Int
    init(with model : LikeResult){
        self.userContentImage = model.imageURL
        self.userImage = model.profileURL
        self.nickName = model.nickname
        self.styleshotIdx = model.styleshotIdx
    }
}
