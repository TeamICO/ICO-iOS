//
//  HomeInHomeVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//

import UIKit


class HomeInHomeVC: BaseViewController {
    // MARK: - Properties

    var canScroll = false
    
    
    @IBOutlet weak var tableView: UITableView!

    private var topBannerModel = [HomeInHomeTopBanner]()
    private var senseStyleShotModel = [HomeInHomeSenseStyleshot]()
    private var brandModel : HomeInHomeBrand?
    private var responsiveStyleShotModel = [HomeInHomePopularStyleshot]()
    private var ecoTopicModel : HomeInHomeEcoTopic?
    private var bottomBanner : HomeInHomeBottomBanner?
    private var nickname = ""

    private var refreshControl = UIRefreshControl()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
        self.tableviewConfigure()
       
    }
    override func viewWillDisappear(_ animated: Bool) {
        canScroll = false
    }
    
  
  

}
// MARK: - FetchData
extension HomeInHomeVC{
    func fetchData(){
        guard let jwtToken = self.jwtToken, let nickname = UserDefaults.standard.string(forKey: "nickname") else{
            return
        }
        self.nickname = nickname
        HomeInHomeManager.shared.getHomeInHomeData(jwtToken: jwtToken) { [weak self] response in
            guard let topBanner = response.topBanner,
                  let senseStyleShot = response.senseStyleshot,
                  let brandRco = response.brand,
                  let responsiveStyleShot = response.popularStyleshot,
                  let ecotopic = response.ecoTopic,
                  let bottom = response.bottomBanner else{
                return
            }
            self?.topBannerModel = topBanner
            self?.senseStyleShotModel = senseStyleShot
            self?.brandModel = brandRco
            self?.responsiveStyleShotModel = responsiveStyleShot
            self?.ecoTopicModel = ecotopic
            self?.bottomBanner = bottom
            self?.tableView.reloadData()
        }
        
    }
}
// MARK: - TableView Configure
extension HomeInHomeVC {
    func tableviewConfigure(){
        refreshControl.alpha = 0
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        let topNib = UINib(nibName: TopTVC.identifier, bundle: nil)
        tableView.register(topNib, forCellReuseIdentifier: TopTVC.identifier)
        
        let sensitiveNib = UINib(nibName: SensibleStyleShotTVC.identifier, bundle: nil)
        tableView.register(sensitiveNib, forCellReuseIdentifier: SensibleStyleShotTVC.identifier)
        
        let bestNib = UINib(nibName: BestTagTVC.identifier, bundle: nil)
        tableView.register(bestNib, forCellReuseIdentifier: BestTagTVC.identifier)
    
        let brandNib = UINib(nibName: BrandRecommendTVC.identifier, bundle: nil)
        tableView.register(brandNib, forCellReuseIdentifier: BrandRecommendTVC.identifier)
        
        let responiveNib = UINib(nibName: ResponsiveStyleShotTVC.identifier, bundle: nil)
        tableView.register(responiveNib, forCellReuseIdentifier: ResponsiveStyleShotTVC.identifier)
        
        let ecoNib = UINib(nibName: EcoTopicTVC.identifier, bundle: nil)
        tableView.register(ecoNib, forCellReuseIdentifier: EcoTopicTVC.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = nil
        tableView.sectionHeaderHeight = 0
        tableView.separatorStyle = .none

    }
}
// MARK: - TableView Delegate, DataSource
extension HomeInHomeVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: TopTVC.identifier, for: indexPath) as! TopTVC
            cell.selectionStyle = .none
            cell.delegate = self
            cell.getData(data: self.topBannerModel)
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: SensibleStyleShotTVC.identifier, for: indexPath) as! SensibleStyleShotTVC
            cell.selectionStyle = .none
            cell.delegate = self
            cell.getData(data: self.senseStyleShotModel,nickname: self.nickname)
            return cell
//        case 2 :
//            let cell = tableView.dequeueReusableCell(withIdentifier: BestTagTVC.identifier, for: indexPath) as! BestTagTVC
//            cell.selectionStyle = .none
//            return cell
        case 2 :
            let cell = tableView.dequeueReusableCell(withIdentifier: BrandRecommendTVC.identifier, for: indexPath) as! BrandRecommendTVC
            cell.selectionStyle = .none
            cell.delegate = self
            if let brand = self.brandModel{
                cell.getData(data: brand,nickname : self.nickname)
            }
            
            return cell
        case 3 :
            let cell = tableView.dequeueReusableCell(withIdentifier: ResponsiveStyleShotTVC.identifier, for: indexPath) as! ResponsiveStyleShotTVC
            cell.delegate = self
            cell.getData(data: self.responsiveStyleShotModel)
            cell.selectionStyle = .none
            return cell
        case 4 :
            let cell = tableView.dequeueReusableCell(withIdentifier: EcoTopicTVC.identifier, for: indexPath) as! EcoTopicTVC
            cell.selectionStyle = .none
            cell.delegate = self
            if let ecoTopic = self.ecoTopicModel{
                cell.getData(data: ecoTopic)
            }
            
            return cell
        default:
            return UITableViewCell()
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       
        switch section {
        case 3 :
            // 광고 배너 높이 조절
            return 70
        case 4:
            return 0
        default:
            return 12
        }
     
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    
        switch section {
        case 3 :
            // 광고 배너 높이 조절
            let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 70))
            let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: footer.width, height: 70))
            if let bottomBanner = self.bottomBanner {
                imageview.setImage(with: bottomBanner.imageURL)
            }
            let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapBottomBannerView))
            viewTap.cancelsTouchesInView = false
            footer.addGestureRecognizer(viewTap)
            footer.addSubview(imageview)
            return footer
        case 4:
            return UIView()
        default:
            let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 12))
            footer.backgroundColor = UIColor.appColor(.tableViewFooterColor)
            return footer
        }
       
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        UIView.animate(withDuration: 0.5) { [weak self] in
                    guard velocity.y != 0 else { return }
                    if velocity.y < 0 {
                        let height = self?.tabBarController?.tabBar.frame.height ?? 0.0
                        self?.tabBarController?.tabBar.alpha = 1.0
                        self?.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY - height)
                    } else {
                    self?.tabBarController?.tabBar.alpha = 0.0
                        self?.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY)
                    }
                }
    }
    @objc func didTapBottomBannerView(){
        if let bottomBanner = self.bottomBanner{
            UIApplication.shared.open(URL(string: bottomBanner.contentURL)! as URL, options: [:], completionHandler: nil)
        }
        
    }
  
}
extension HomeInHomeVC : TopTVCDelegate {
    func didTapBannerView(index: String) {
        guard let index = Int(index) else{
            return
        }
        print(index)
        let styleDetailSB = UIStoryboard(name: "StyleDetail", bundle: nil)
        let styleDetailVC = styleDetailSB.instantiateViewController(withIdentifier: "StyleDetailVC")as! StyleDetailVC
        styleDetailVC.styleShotIdx = index
        self.navigationController?.pushViewController(styleDetailVC, animated: true)
    }
    
    func didTapKeywordContents(index: Int) {
        let sb = UIStoryboard(name: "KeywordContentsSB", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "KeywordContentsVC")as! KeywordContentsVC
        vc.index = index
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapSearchView() {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationPushViewController(storyboard: "SearchSB", identifier: "SearchVC")

    }
    
    
}
extension HomeInHomeVC : BrandRecommendTVCDelegate{
  
    
    func didTapBrandView() {
        guard let brandModel = self.brandModel else{
            return
        }
        UIApplication.shared.open(URL(string: brandModel.contentURL )! as URL, options: [:], completionHandler: nil)
    }
    
    
}

extension HomeInHomeVC : SensibleStyleShotTVCDelegate, ResponsiveStyleShotTVCDelegate , EcoTopicTVCDelegate{
    func didTapEachCells(styleShotIdx: Int, userNickName: String) {
        if self.nickName == userNickName {

            pushToStyleShot(isMine: true, styleShotIdx: styleShotIdx)
        }else{
      
            pushToStyleShot(isMine: false, styleShotIdx: styleShotIdx)
        }
    }
    
   
    func pushToStyleShot(isMine : Bool,styleShotIdx : Int){
        let styleDetailSB = UIStoryboard(name: "StyleDetail", bundle: nil)
        let styleDetailVC = styleDetailSB.instantiateViewController(withIdentifier: "StyleDetailVC")as! StyleDetailVC
        styleDetailVC.isMine = isMine
        styleDetailVC.styleShotIdx = styleShotIdx
        self.navigationController?.pushViewController(styleDetailVC, animated: true)
    }
    
}
extension HomeInHomeVC{
    @objc func refresh(){
            

    }
    
     func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if (refreshControl.isRefreshing) {
                self.fetchData()
                self.refreshControl.endRefreshing()
                
            }
    }
}
