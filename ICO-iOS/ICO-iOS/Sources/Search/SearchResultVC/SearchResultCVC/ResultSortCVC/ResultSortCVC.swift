//
//  ResultSortCVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

protocol ResultSortCVCDelegate : AnyObject{
    func didTapSort(sortedIdx: Int)
}

class ResultSortCVC: UICollectionViewCell {
    static let identifier = "ResultSortCVC"
    
    weak var delegate : ResultSortCVCDelegate?
    
    private var emojis = ["emoji-search-accuracy","emoji-search-like","emoji-search-star"]
    private var sortTitles = ["정확도순","좋아요순","아이코 만족도순"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewConfigure()
    }

}
// MARK: - CollectionView Configure
extension ResultSortCVC {
    func collectionViewConfigure(){
        collectionView.backgroundColor = .white
//        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: SortCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: SortCVC.identifier)
        
    }
}
extension ResultSortCVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SortCVC.identifier, for: indexPath) as! SortCVC
        cell.delegate = self
        cell.sortIcon.image = UIImage(named: emojis[indexPath.row])
        cell.sortTitleLabel.text = sortTitles[indexPath.row]
        cell.sortedIdx = indexPath.row
        if indexPath.row == 0{
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SortCVC.identifier, for: indexPath) as! SortCVC
        return CGSize(width: sortTitles[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width+cell.sortIcon.frame.size.width + 26, height: 25)
    }
    
}
extension ResultSortCVC : SortCVCDelagate{
    func didTapSort(sortedIdx: Int) {
        delegate?.didTapSort(sortedIdx: sortedIdx)
    }
    
    
}
