//
//  EcoTopicCVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/03.
//

import UIKit

class EcoTopicCVC: UICollectionViewCell {
    static let identifier = "EcoTopicCVC"
    
    var category = [String]()
    
    @IBOutlet weak var userContentImage: UIImageView!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var nickName: UILabel!
    
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        gradientView.setGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: .white)
        
        collectionViewConfigure()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        userContentImage.image = nil
        userImage.image = nil
        nickName.text = nil
    }
    func getData(data : [String]){
        self.category = data
        
        collectionView.reloadData()
    }
}

// MARK: - CollectionView Configure
extension EcoTopicCVC {
    func collectionViewConfigure(){

        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: EcoTopicCollectionViewCellCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: EcoTopicCollectionViewCellCVC.identifier)
        
    }
    func configure(with viewModel : EcoTopicCVCViewModel){
        self.nickName.text = viewModel.nickName
        self.userContentImage.setImage(with: viewModel.userContentImage)
        self.userImage.setImage(with: viewModel.userImage)
      
        
    }
    
}
extension EcoTopicCVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}
struct EcoTopicCVCViewModel {
    let userContentImage : String
    let userImage : String
    let nickName : String
    
    init(with model : HomeInHomeSenseStyleshot){
        self.userContentImage = model.imageURL
        self.userImage = model.profileURL
        self.nickName = model.nickname
        
    }
}
