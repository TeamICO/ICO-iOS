//
//  ResponsiveStyleShotTVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/07.
//

import UIKit

class ResponsiveStyleShotTVC: UITableViewCell {
    static let identifier = "ResponsiveStyleShotTVC"
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    private var responsiveStyleShotModel = [HomeInHomePopularStyleshot]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewConfigure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func getData(data : [HomeInHomePopularStyleshot]){
        self.responsiveStyleShotModel = data
       
        
        collectionView.reloadData()
    }
    
}
// MARK: - CollectionView Configure
extension ResponsiveStyleShotTVC {
    func collectionViewConfigure(){

        
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: ResponsiveCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ResponsiveCVC.identifier)
        
    }
}
extension ResponsiveStyleShotTVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return responsiveStyleShotModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResponsiveCVC.identifier, for: indexPath) as! ResponsiveCVC
        cell.getData(data: self.responsiveStyleShotModel[indexPath.row].category,rating: self.responsiveStyleShotModel[indexPath.row].point)
        cell.configure(with: ResponsiveCVCViewModel(with: self.responsiveStyleShotModel[indexPath.row]))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
      
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 196)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        pageControl.currentPage = Int(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width))
        
        
    }
}
