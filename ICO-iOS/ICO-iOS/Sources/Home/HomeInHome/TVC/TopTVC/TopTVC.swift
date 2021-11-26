//
//  TopTVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/07.
//

import UIKit

protocol TopTVCDelegate : AnyObject {
    func didTapSearchView()
    func didTapKeywordContents(index : Int)
    func didTapBannerView(index : String)
}

class TopTVC: UITableViewCell {
    
    
    
    // MARK: - Properties
    static let identifier = "TopTVC"
    
    weak var delegate : TopTVCDelegate?
    
    var topBannerModel = [HomeInHomeTopBanner]()
    
    var nowPage: Int = 0
    
    let keywordContentsImages = ["illust-product-vegan",
                                 "illust-styleshot-upcycling",
                                 "illust-styleshot-zerowaste"]
    let keywordContents = ["비건","업사이클링","지구를"]
    let keywordContentsSub = ["을 위한 뷰티",
                                 " 패션",
                                 " 위한 패키지"]
 
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    
    private let pageControl : UIPageControl = {
       let page = UIPageControl()
        page.numberOfPages = 3
        page.tintColor = .primaryBlack30
        page.currentPageIndicatorTintColor = .primaryBlack50
        page.translatesAutoresizingMaskIntoConstraints = false
        return page
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pageControlConfigure()
        collectionViewConfigure()
        bannerTimer()
        setTapGesture()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    func getData(data : [HomeInHomeTopBanner]){
        self.topBannerModel = data
        
        bannerCollectionView.reloadData()
    }
    
    func setTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapSearchView))
        viewTap.cancelsTouchesInView = false
        searchView.addGestureRecognizer(viewTap)
    }
    @objc func didTapSearchView(){
        delegate?.didTapSearchView()
    }
}
// MARK: - CollectionView Configure
extension TopTVC {
    func collectionViewConfigure(){
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: TopCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TopCVC.identifier)
        let bannerNib = UINib(nibName: TopBannerCVC.identifier, bundle: nil)
        bannerCollectionView.register(bannerNib, forCellWithReuseIdentifier: TopBannerCVC.identifier)
        bannerCollectionView.backgroundColor = .white
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
    }
}
extension TopTVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.collectionView : return 3
        case self.bannerCollectionView : return topBannerModel.count
        default : return 3
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.collectionView :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCVC.identifier, for: indexPath) as! TopCVC
            cell.configure(with: TopCVCViewModel(iconImage: keywordContentsImages[indexPath.row],
                                                 ecoTitle: keywordContents[indexPath.row],
                                                 ecoSubTitle: keywordContentsSub[indexPath.row]))
            return cell
        case self.bannerCollectionView :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopBannerCVC.identifier, for: indexPath) as! TopBannerCVC
            cell.bannerImage.setImage(with: topBannerModel[indexPath.row].imageURL)
//            cell.delegate = self
            return cell
        default : return UICollectionViewCell()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        if collectionView == self.collectionView{
            delegate?.didTapKeywordContents(index: indexPath.row)
        }else if collectionView == self.bannerCollectionView{
            delegate?.didTapBannerView(index: topBannerModel[indexPath.row].content)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case self.collectionView :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCVC.identifier, for: indexPath) as! TopCVC
            
           return CGSize(width:  keywordContents[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width + keywordContentsSub[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width + cell.ecoIcon.frame.size.width + 26, height: 32)

    
        case self.bannerCollectionView :
            return CGSize(width: self.frame.size.width, height: 118)
        default : return CGSize()
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.bannerCollectionView {
            return 0
        }else{
            return 8
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.bannerCollectionView {
            return 0
        }else{
            return 8
        }
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        pageControl.currentPage = Int(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width))
        
        nowPage =  Int(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width))
    }
}
// MARK: - PageControl Configure
extension TopTVC {
    func pageControlConfigure(){
        contentView.addSubview(pageControl)
        
        pageControl.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: -5).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: searchView.topAnchor,constant: -20).isActive = true
        
    }
}


// MARK: - Banner Scolling
extension TopTVC {
    func bannerTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (Timer) in
            self.bannerMove()
        }
    }
    // 배너 움직이는 매서드
    func bannerMove() {
        // 현재페이지가 마지막 페이지일 경우
        if nowPage == topBannerModel.count-1 {
            // 맨 처음 페이지로 돌아감
            bannerCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
            nowPage = 0
            return
        }
        // 다음 페이지로 전환
        nowPage += 1
        bannerCollectionView.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .right, animated: true)
    }
    
}

