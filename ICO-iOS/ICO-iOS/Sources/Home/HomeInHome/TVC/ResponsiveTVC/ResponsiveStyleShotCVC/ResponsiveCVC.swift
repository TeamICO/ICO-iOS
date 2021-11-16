//
//  ResponsiveCVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/05.
//

import UIKit

class ResponsiveCVC: UICollectionViewCell {
    static let identifier = "ResponsiveCVC"
        
    let cartegoryModels = ["유기농", "클린뷰티","ㅁㄴㅇㅁ"]
    let cartegoryFontColors : [UIColor] = [UIColor.appColor(.categoryFontRed),UIColor.appColor(.categoryFontGreen),UIColor.appColor(.categoryFontGreen)]
    let cartegoryBackColors : [UIColor] = [UIColor.appColor(.categoryBackgroundRed),UIColor.appColor(.categoryBackgroundGreen),UIColor.appColor(.categoryBackgroundGreen)]
    
    
    @IBOutlet weak var userContentImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nicNameLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var userRatingLabel: UILabel!
    
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var gradientView2: UIView!
    @IBOutlet weak var userSatisfactionStack: UIStackView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gradientView.setGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: .white)
        gradientView2.setGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: .white)
        
        
        setCellShadow()
        setUserSatisfactionStack()
        collectionViewConfigure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.userContentImage.image = nil
        self.userImage.image = nil
        self.nicNameLabel.text = nil
        self.productNameLabel.text = nil
        self.userRatingLabel.text = nil
    }

    func setUserSatisfactionStack(){
        for _ in 0...4{
            let stack = UserRatingsSV()
            userSatisfactionStack.addArrangedSubview(stack)
        }
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

        guard let userUrl = URL(string: viewModel.userImage), let contentImage = URL(string: viewModel.userContentImage) else{
                return
            }
        setImage(url: contentImage, imageV: self.userContentImage)
        setImage(url: userUrl, imageV: self.userImage)
        
        
    }
    func setImage(url : URL,imageV : UIImageView){
        DispatchQueue.global().async {
                let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                    guard let data = data else{
                        return
                    }
                    
                    DispatchQueue.main.async {
                        imageV.image = UIImage(data: data)
                    }
                }
                task.resume()
        }
    }
}
extension ResponsiveCVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResponsiveCollectionViewCellCVC.identifier, for: indexPath) as! ResponsiveCollectionViewCellCVC
        cell.categoryLabel.text = cartegoryModels[indexPath.row]
        cell.categoryLabel.backgroundColor = cartegoryBackColors[indexPath.row]
        cell.categoryLabel.textColor = cartegoryFontColors[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cartegoryModels[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]).width + 12, height: 25)
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
