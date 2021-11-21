//
//  ResponsiveCVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/05.
//

import UIKit

class ResponsiveCVC: UICollectionViewCell {
    static let identifier = "ResponsiveCVC"
        
    var category = [String]()
    var rating = 0
    
    
    @IBOutlet weak var userContentImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nicNameLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var userRatingLabel: UILabel!
    
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var gradientView2: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gradientView.setGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: .white)
        gradientView2.setGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: .white)
        
        
        setCellShadow()
        
        collectionViewConfigure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.userContentImage.image = nil
        self.userImage.image = nil
        self.nicNameLabel.text = nil
        self.productNameLabel.text = nil
        self.userRatingLabel.text = nil
        rating = 0
    }
    func getData(data : [String],rating : Int){
        self.category = data
        self.rating = rating
        collectionView.reloadData()
        
    }
    
    //MARK : Cell Configure
    func setCellShadow(){
        content.layer.shadowColor = UIColor(red: 0.188, green: 0.188, blue: 0.188, alpha: 0.1).cgColor
        content.layer.shadowOpacity = 1
        content.layer.shadowRadius = 16
        content.layer.cornerRadius = 16
        content.layer.shadowOffset = CGSize(width: 10, height: 10)
        
    }
}

// MARK: - CollectionView Configure
extension ResponsiveCVC {
    func collectionViewConfigure(){

        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: ResponsiveCollectionViewCellCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ResponsiveCollectionViewCellCVC.identifier)
        
    }
    func configure(with viewModel : ResponsiveCVCViewModel){
        self.nicNameLabel.text = viewModel.nicName
        self.productNameLabel.text = viewModel.productName
        self.userRatingLabel.text = "\(viewModel.userRating).0"
        self.ratingImageView.image = UIImage(named: "ic-styleshot-upload-ecolevel-\(viewModel.userRating)")
        self.userImage.setImage(with: viewModel.userImage)
        self.userContentImage.setImage(with: viewModel.userContentImage)
     
        
        
    }

}
extension ResponsiveCVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResponsiveCollectionViewCellCVC.identifier, for: indexPath) as! ResponsiveCollectionViewCellCVC
        cell.categoryLabel.text = category[indexPath.row]
        cell.categoryLabel.setLabelConfigure(label: cell.categoryLabel, styleShotCategoryType: category[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: category[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]).width + 12, height: 25)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}
struct ResponsiveCVCViewModel {
    let userContentImage : String
    let userImage : String
    let userRating : Int
    let nicName : String
    let productName : String
    init(with model : HomeInHomePopularStyleshot){
        self.userContentImage = model.imageURL
        self.userImage = model.profileURL
        self.userRating = model.point
        self.nicName = model.nickname
        self.productName = model.productName
    }
}
