//
//  RecentSearchWordsTVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/07.
//

import UIKit

class RecentSearchWordsTVC: UITableViewCell {
    static let identifier = "RecentSearchWordsTVC"

    @IBOutlet weak var collectionView: UICollectionView!
    
    var arr = ["사과","피자","핫도그","토스트","12342353"]
    private var keywordHistory = [KeywordHistory]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewConfigure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    func getData(data: [KeywordHistory]){
        self.keywordHistory = data
        
        self.collectionView.reloadData()
    }
    
    @IBAction func didTapDeleteAllButton(_ sender: Any) {
    }
}
// MARK: - CollectionView Configure
extension RecentSearchWordsTVC {
    func collectionViewConfigure(){
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: RecentCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: RecentCVC.identifier)
        
    }

   
}
extension RecentSearchWordsTVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywordHistory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCVC.identifier, for: indexPath) as! RecentCVC
        cell.wordLabel.text = keywordHistory[indexPath.row].keyword
        cell.keywordIdx = keywordHistory[indexPath.row].keywordIdx
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: RecentCVC.identifier, for: indexPath) as! RecentCVC
        return CGSize(width: keywordHistory[indexPath.row].keyword.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]).width+cell.deleteButton.frame.size.width + 28, height: 28)
    }
   
}
extension RecentSearchWordsTVC : RecentCVCDelegate{
    func didTapDeleteWordButton(keywordIdx: Int) {
        guard let jwtToken = UserDefaults.standard.string(forKey: "jwtToken") else{
            return
        }
        SearchManager.shared.removeKeywordHistory(keywordIdx: keywordIdx, jwtToken: jwtToken) { deleted in
            guard deleted else{
                print("삭제 실패")
                return
            }
            self.collectionView.reloadData()
        }
    }
    
 
    
    
}
