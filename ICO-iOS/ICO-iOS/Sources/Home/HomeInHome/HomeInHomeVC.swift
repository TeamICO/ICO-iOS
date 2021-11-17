//
//  HomeInHomeVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//

import UIKit

class HomeInHomeVC: BaseViewController {
    // MARK: - Properties

    @IBOutlet weak var tableView: UITableView!
    
    private var topBannerModel = [HomeInHomeTopBanner]()
    private var senseStyleShotModel = [HomeInHomeSenseStyleshot]()
    private var brandModel : HomeInHomeBrand?
    private var responsiveStyleShotModel = [HomeInHomePopularStyleshot]()
    private var ecoTopicModel : HomeInHomeEcoTopic?
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
        self.tableviewConfigure()
    }
    



}
// MARK: - FetchData
extension HomeInHomeVC{
    func fetchData(){
        guard let jwtToken = self.jwtToken else{
            return
        }
        HomeInHomeManager.shared.getHomeInHomeData(jwtToken: jwtToken) { [weak self] response in
            guard let topBanner = response.topBanner,
                  let senseStyleShot = response.senseStyleshot,
                  let brandRco = response.brand,
                  let responsiveStyleShot = response.popularStyleshot,
                  let ecotopic = response.ecoTopic else{
                return
            }
            self?.topBannerModel = topBanner
            self?.senseStyleShotModel = senseStyleShot
            self?.brandModel = brandRco
            self?.responsiveStyleShotModel = responsiveStyleShot
            self?.ecoTopicModel = ecotopic
            self?.tableView.reloadData()
        }
        
    }
}
// MARK: - TableView Configure
extension HomeInHomeVC {
    func tableviewConfigure(){
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
            cell.getData(data: self.senseStyleShotModel)
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
                cell.getData(data: brand)
            }
            
            return cell
        case 3 :
            let cell = tableView.dequeueReusableCell(withIdentifier: ResponsiveStyleShotTVC.identifier, for: indexPath) as! ResponsiveStyleShotTVC
            cell.getData(data: self.responsiveStyleShotModel)
            cell.selectionStyle = .none
            return cell
        case 4 :
            let cell = tableView.dequeueReusableCell(withIdentifier: EcoTopicTVC.identifier, for: indexPath) as! EcoTopicTVC
            cell.selectionStyle = .none
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
            let footer = UIImageView(frame: CGRect(x: 0, y: 0, width: view.width, height: 70))
            footer.image = UIImage(named: "img_home_adbanner")
            return footer
        case 4:
            return UIView()
        default:
            let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 12))
            footer.backgroundColor = UIColor.appColor(.tableViewFooterColor)
            return footer
        }
       
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offset = scrollView.contentOffset.y
//        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
 
    
}
extension HomeInHomeVC : TopTVCDelegate {
    func didTapSearchView() {
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
