//
//  SearchResultsCVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit


class SearchResultsCVC: UICollectionViewCell {
    static let identifier = "SearchResultsCVC"


    var category = [String]()
    
    @IBOutlet weak var userContentImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var gradientView: UIView!
    
    // MARK : Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        gradientView.setGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: .white)
        collectionViewConfigure()
    }
    func getData(data : [String]){
        self.category = data
        
        collectionView.reloadData()
    }
  
}

// MARK: - CollectionView Configure
extension SearchResultsCVC {
    func collectionViewConfigure(){
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: SearchResultCollectionViewCellCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: SearchResultCollectionViewCellCVC.identifier)
        
    }
    func configure(with viewModel : SearchResultsCVCViewModel){
        self.userNameLabel.text = viewModel.nicName
        self.userContentImage.setImage(with: viewModel.userContentImage)
        if viewModel.userImage == ""{
            self.userImage.image = UIImage(named: "img_profile_default")
        }else{
            self.userImage.setImage(with: viewModel.userImage)
        }
        if viewModel.isLike == 1{
            likeImage.image = UIImage(named: "ic-heart-click")
        }else{
            likeImage.image = UIImage(named: "icHeartUnclick1")
        }
        
    }

}
extension SearchResultsCVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCellCVC.identifier, for: indexPath) as! SearchResultCollectionViewCellCVC
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
struct SearchResultsCVCViewModel {
    let userContentImage : String
    let userImage : String
    let nicName : String
    let isLike : Int
    
    init(with model : SeachResultData){
        self.userContentImage = model.imageURL
        self.userImage = model.profileURL
        self.nicName = model.nickname
        self.isLike = model.isLike
        
    }
}
