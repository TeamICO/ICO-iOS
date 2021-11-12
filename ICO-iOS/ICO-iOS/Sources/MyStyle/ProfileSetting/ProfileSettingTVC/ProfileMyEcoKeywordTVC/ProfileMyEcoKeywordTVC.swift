//
//  ProfileMyEcoKeywordTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/11.
//

import UIKit

class ProfileMyEcoKeywordTVC: UITableViewCell {
    static let identifier = "ProfileMyEcoKeywordTVC"
    @IBOutlet weak var companyCollectionView: UICollectionView!
    
    let arr = ["또띠아",
               "버터",
               "달걀",
               "치즈볼",
               "쪽파",
               "진미채",
               "참외",
               "케이크",
               "새우",
               "대패삼겹살"]
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewConfigure()
//        donationButton.setImage(UIImage(named: "emoji-profile-check"), for: .normal)
//        donationButton.imageView?.contentMode = .scaleAspectFit
//        donationButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }
    
}
// MARK: - CollectionView Configure
extension ProfileMyEcoKeywordTVC {
    func collectionViewConfigure(){
        
        companyCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        companyCollectionView.delegate = self
        companyCollectionView.dataSource = self
       
        companyCollectionView.register(CompanyKeywordCVC.self, forCellWithReuseIdentifier: CompanyKeywordCVC.identifier)
        
    }
}
extension ProfileMyEcoKeywordTVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyKeywordCVC.identifier, for: indexPath) as! CompanyKeywordCVC
        cell.configure(name: arr[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
      
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CompanyKeywordCVC.fittingSize(availableHeight: 32, name: arr[indexPath.row])
       }
    
}
