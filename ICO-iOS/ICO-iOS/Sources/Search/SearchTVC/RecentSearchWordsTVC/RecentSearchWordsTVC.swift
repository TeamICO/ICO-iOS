//
//  RecentSearchWordsTVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/07.
//

import UIKit
protocol RecentSearchWordsTVCDelegate : AnyObject{
    func didTapSearchKeyword(keyword : String)
    
}

class RecentSearchWordsTVC: UITableViewCell {
    static let identifier = "RecentSearchWordsTVC"
    
    weak var delegate : RecentSearchWordsTVCDelegate?

    @IBOutlet weak var collectionView: UICollectionView!

    private var keywordHistory = [KeywordHistory]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewConfigure()
    }

  
  
    func getData(data: [KeywordHistory]){
        self.keywordHistory = data
        
        self.collectionView.reloadData()
    }
    
    @IBAction func didTapDeleteAllButton(_ sender: Any) {
        guard let jwtToken = UserDefaults.standard.string(forKey: "jwtToken") else{
            return
        }
        SearchManager.shared.removeAllKeywordHistory(jwtToken: jwtToken) { deleted in
            guard deleted else{
                print("삭제 실패")
                return
            }
            SearchManager.shared.getKeywordHistory(jwtToken: jwtToken) { keywords in
                guard let keywords = keywords else {
                    return
                }
                self.keywordHistory = keywords
                self.collectionView.reloadData()
            }
        }
    }
}
// MARK: - CollectionView Configure
extension RecentSearchWordsTVC {
    func collectionViewConfigure(){
        collectionView.backgroundColor = .white
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
    func didtapKeywordView(keyword: String) {
        delegate?.didTapSearchKeyword(keyword: keyword)
    }
    

    
    func didTapDeleteWordButton(keywordIdx: Int) {
        guard let jwtToken = UserDefaults.standard.string(forKey: "jwtToken") else{
            return
        }
        SearchManager.shared.removeKeywordHistory(keywordIdx: keywordIdx, jwtToken: jwtToken) { deleted in
            guard deleted else{
                print("삭제 실패")
                return
            }
            SearchManager.shared.getKeywordHistory(jwtToken: jwtToken) { keywords in
                guard let keywords = keywords else {
                    return
                }
                self.keywordHistory = keywords
                self.collectionView.reloadData()
            }
        }
    }
    
 
    
    
}
