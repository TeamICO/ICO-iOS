//
//  RecentTVC.swift
//  ICO
//
//  Created by 이은영 on 2021/11/04.
//

import UIKit

class RecentTVC: UITableViewCell {
    
    var category: [String] = []
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var heartNum: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var ecoLevelImg: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var gradientView2: UIView!
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var categoryCV: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
        setCV()
    }
    
    func setData(category: [String]){
        self.category = category
        
        categoryCV.reloadData()
    }
    
    func setCV(){
        categoryCV.delegate = self
        categoryCV.dataSource = self
        categoryCV.register(UINib(nibName: "TagCVC", bundle: nil), forCellWithReuseIdentifier: "TagCVC")
    }
    
    func setUI(){
        gradientView.setGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: .white)
        gradientView2.setGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: .white)
        
        nameLabel.textColor = UIColor.primaryBlack80
        score.textColor = .coGreen
        time.textColor = UIColor.tabBarGray
        time.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
        userImage.contentMode = .scaleAspectFill
        userImage.clipsToBounds = true
        userImage.layer.cornerRadius = 20
        userImage.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = UIColor.backGround1
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

extension RecentTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCVC", for: indexPath)as? TagCVC else {return UICollectionViewCell()}
        cell.categoryLabel.text = category[indexPath.row]
        cell.categoryLabel.setLabelConfigure(label: cell.categoryLabel, styleShotCategoryType: category[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: category[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]).width + 12, height: 25)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
}
