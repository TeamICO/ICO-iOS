//
//  SensibleCVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/07.
//

import UIKit

class SensibleCVC: UICollectionViewCell {
    static let identifier = "SensibleCVC"
    
    var category = [String]()
    
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
 
    override func prepareForReuse() {
        super.prepareForReuse()
        styleShotImage.image = nil
        userImage.image = nil
        userId.text = nil
    }
    func getData(data : [String]){
        self.category = data
        
        collectionView.reloadData()
    }
    func configure(with viewModel : SensibleCVCViewModel){
        
        self.userId.text = viewModel.nicName
        
        guard let styleShotUrl = URL(string: viewModel.styleShotImage), let userImageUrl = URL(string: viewModel.userImage) else{
                return
            }
        setImage(url: styleShotUrl, imageV: self.styleShotImage)
        setImage(url: userImageUrl, imageV: self.userImage)
        
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
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SensibleCollectionViewCellCVC.identifier, for: indexPath) as! SensibleCollectionViewCellCVC
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

struct SensibleCVCViewModel {
    let styleShotImage : String
    let userImage : String
    let nicName : String
    
    init(with model : HomeInHomeSenseStyleshot){
        self.styleShotImage = model.imageURL
        self.userImage = model.profileURL
        self.nicName = model.nickname
    
    }
}
