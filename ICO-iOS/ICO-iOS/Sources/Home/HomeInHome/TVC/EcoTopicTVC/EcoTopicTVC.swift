//
//  EcoTopicTVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/07.
//

import UIKit

protocol EcoTopicTVCDelegate : AnyObject{
    func didTapEachCells(styleShotIdx : Int, userNickName : String)
}


class EcoTopicTVC: UITableViewCell {
    static let identifier = "EcoTopicTVC"
    
    weak var delegate : EcoTopicTVCDelegate?
    
    var ecoTopicModel : HomeInHomeEcoTopic?
    
    @IBOutlet weak var topicTitle: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewConfigure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.topicTitle.text = nil
        self.productImage.image = nil
    }
    
    func getData(data : HomeInHomeEcoTopic){
        self.ecoTopicModel = data
        topicTitle.text = data.name
        self.productImage.setImage(with: data.imageURL)

        collectionView.reloadData()
    }
    
}
// MARK: - CollectionView Configure
extension EcoTopicTVC {
    func collectionViewConfigure(){
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: EcoTopicCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: EcoTopicCVC.identifier)
        
    }
}
extension EcoTopicTVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ecoTopicModel?.product.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EcoTopicCVC.identifier, for: indexPath) as! EcoTopicCVC
        if let product = ecoTopicModel?.product{
            cell.getData(data: product[indexPath.row].category)
            cell.configure(with: EcoTopicCVCViewModel(with: product[indexPath.row]))
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        if let product = ecoTopicModel?.product{
            delegate?.didTapEachCells(styleShotIdx: product[indexPath.row].styleshotIdx,userNickName: product[indexPath.row].nickname)
        }
       
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 187)
    }
    
}
