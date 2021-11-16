//
//  EcoTopicCVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/03.
//

import UIKit

class EcoTopicCVC: UICollectionViewCell {
    static let identifier = "EcoTopicCVC"
    
    let cartegoryModels = ["유기농", "클린뷰티","ㅁㄴㅇㅁ"]
    let cartegoryFontColors : [UIColor] = [UIColor.appColor(.categoryFontRed),UIColor.appColor(.categoryFontGreen),UIColor.appColor(.categoryFontGreen)]
    let cartegoryBackColors : [UIColor] = [UIColor.appColor(.categoryBackgroundRed),UIColor.appColor(.categoryBackgroundGreen),UIColor.appColor(.categoryBackgroundGreen)]
    
    @IBOutlet weak var userContentImage: UIImageView!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var nicName: UILabel!
    
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
        nicName.text = nil
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
        self.nicName.text = viewModel.nicName

        guard let productUrl = URL(string: viewModel.userContentImage), let userUrl = URL(string: viewModel.userImage) else{
                return
            }
        setImage(url: productUrl, imageV: self.userContentImage)
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
extension EcoTopicCVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EcoTopicCollectionViewCellCVC.identifier, for: indexPath) as! EcoTopicCollectionViewCellCVC
        cell.categoryLabel.text = cartegoryModels[indexPath.row]
        cell.categoryLabel.backgroundColor = cartegoryBackColors[indexPath.row]
        cell.categoryLabel.textColor = cartegoryFontColors[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cartegoryModels[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]).width + 12, height: 25)
    }
    
}
struct EcoTopicCVCViewModel {
    let userContentImage : String
    let userImage : String
    let nicName : String
    
    init(with model : HomeInHomeSenseStyleshot){
        self.userContentImage = model.imageURL
        self.userImage = model.profileURL
        self.nicName = model.nickname
        
    }
}
