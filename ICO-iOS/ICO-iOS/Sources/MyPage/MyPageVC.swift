//
//  MyPageVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//

import UIKit
import KakaoSDKAuth
import NaverThirdPartyLogin
class MyPageVC: BaseViewController {
    // MARK: - Properties
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    private var mypageModel : MypageResult?
    
    private var featureModels = [
                "",
                "",
                "서비스 이용 약관",
                "알림 설정",
                "의견 보내기",
                "로그아웃",
                ""
            
    ]
    
    @IBOutlet weak var alarmIcon: UIImageView!
    @IBOutlet weak var alarmIconWidth: NSLayoutConstraint!
    @IBOutlet weak var alarmIconHeight: NSLayoutConstraint!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var alarmView: UIView!
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var refreshControl = UIRefreshControl()
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkInternet()
        alarmConfigure()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkInternet()
        
        fetchData()
        tableviewConfigure()
        setLikeViewTapGesture()
        setAlarmViewTapGesture()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setBlurEffect(view: topView)
    }

   

}
// MARK: - FetchData
extension MyPageVC{
    func fetchData(){
        guard let jwtToken = self.jwtToken else{
            return
        }
        MypageManager.shared.getMypageData(jwtToken : jwtToken) { [weak self] response in
            guard let response = response else{
                return
            }
            self?.mypageModel = response
            self?.tableView.reloadData()
        }
    }
}

// MARK: - TableView Configure
extension MyPageVC {
    func tableviewConfigure(){
        refreshControl.alpha = 0
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        let myPageUserInfoTVCNib = UINib(nibName: MyPageUserInfoTVC.identifier, bundle: nil)
        tableView.register(myPageUserInfoTVCNib, forCellReuseIdentifier: MyPageUserInfoTVC.identifier)
        
        let mypageMyRecentStyleShotTVCNib = UINib(nibName: MypageMyRecentStyleShotTVC.identifier, bundle: nil)
        tableView.register(mypageMyRecentStyleShotTVCNib, forCellReuseIdentifier: MypageMyRecentStyleShotTVC.identifier)
        
        
        let mypageTVCNib = UINib(nibName: MypageTVC.identifier, bundle: nil)
        tableView.register(mypageTVCNib, forCellReuseIdentifier: MypageTVC.identifier)
        
        let icoVerTVCNib = UINib(nibName: IcoVerTVC.identifier, bundle: nil)
        tableView.register(icoVerTVCNib, forCellReuseIdentifier: IcoVerTVC.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = nil
        tableView.sectionHeaderHeight = 0
        tableView.separatorStyle = .none
        // 네비게이션 pop 제스처
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

    }
}
// MARK: - TableView Delegate, DataSource
extension MyPageVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.appColor(.tableViewCellColor)
        switch indexPath.section{
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: MyPageUserInfoTVC.identifier, for: indexPath) as! MyPageUserInfoTVC
            cell.selectionStyle = .none
            cell.delegate = self
            if let mypageModel = self.mypageModel{
                cell.configure(with: MyPageUserInfoTVCViewModel(with: mypageModel))
            }
            
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: MypageMyRecentStyleShotTVC.identifier, for: indexPath) as! MypageMyRecentStyleShotTVC
            cell.delegate = self
            cell.selectionStyle = .none
            if let model = self.mypageModel?.styleshot{
                cell.getData(data: model)
            }
            
            return cell
        case 6 :
            let cell = tableView.dequeueReusableCell(withIdentifier: IcoVerTVC.identifier, for: indexPath) as! IcoVerTVC
            cell.selectionStyle = .none
          
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: MypageTVC.identifier, for: indexPath) as! MypageTVC
            cell.selectedBackgroundView =  bgColorView
            cell.featureLabel.text = featureModels[indexPath.section]
            return cell
     
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        switch indexPath.section {
        case 0 : self.tabBarController?.tabBar.isHidden = false
            break
        case 1 :
            self.tabBarController?.tabBar.isHidden = false
            self.tabBarController?.selectedIndex = 1
            break
        case 2:
            // 서비스 이용 약관
            let storyboard = UIStoryboard(name: "ServiceTermsSB", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "ServiceTermsVC") as! ServiceTermsVC
            vc.navigationItem.largeTitleDisplayMode = .never
            vc.complition = { taped in
                self.tabBarController?.selectedIndex = 0
            }
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        case 3:
            // 알림 설정
            let storyboard = UIStoryboard(name: "SettingAlarmSB", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "SettingAlarmVC") as! SettingAlarmVC
            vc.navigationItem.largeTitleDisplayMode = .never
            vc.complition = { taped in
                self.tabBarController?.selectedIndex = 0
            }
            self.navigationController?.pushViewController(vc, animated: true)
      
            break
        case 4:
            // 의견 보내기
            let storyboard = UIStoryboard(name: "FeedbackSB", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "FeedbackVC") as! FeedbackVC
            vc.navigationItem.largeTitleDisplayMode = .never
            vc.complition = { taped in
                self.tabBarController?.selectedIndex = 0
            }
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 5:
            // 로그아웃
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let action = UIAlertAction(title: "로그아웃", style: .default, handler:{ [weak self]_ in
                
                UserDefaults.standard.set(nil, forKey: "jwtToken")
                UserDefaults.standard.set(nil, forKey: "userIdx")
                UserDefaults.standard.set(nil, forKey: "nickname")
                if ((self?.loginInstance?.isValidAccessTokenExpireTimeNow()) != nil){
                    self?.loginInstance?.requestDeleteToken()
                    let loginStoryboard = UIStoryboard(name: "LoginSB", bundle: nil)
                    let loginVC = loginStoryboard.instantiateViewController(identifier: "LoginVC")
                    loginVC.navigationItem.largeTitleDisplayMode = .never
                    let vc = UINavigationController(rootViewController: loginVC)
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true, completion: nil)
                }
                if AuthApi.hasToken(){
                    LoginManager.shared.signOut { success in
                        guard success else{
                            return
                        }
                        DispatchQueue.main.async {
                            let loginStoryboard = UIStoryboard(name: "LoginSB", bundle: nil)
                            let loginVC = loginStoryboard.instantiateViewController(identifier: "LoginVC")
                            loginVC.navigationItem.largeTitleDisplayMode = .never
                            let vc = UINavigationController(rootViewController: loginVC)
                            vc.modalPresentationStyle = .fullScreen
                            self?.present(vc, animated: true, completion: nil)
                        }
                    }
                }
          
            })
            action.setValue(UIColor.appColor(.alertRed), forKey: "titleTextColor")
            actionSheet.addAction(action)
     
            let cancel = UIAlertAction(title: "취소", style: .cancel,handler: {_ in
                self.tabBarController?.tabBar.isHidden = false
                
            })
            cancel.setValue(UIColor.appColor(.alertBlack), forKey: "titleTextColor")
            actionSheet.addAction(cancel)
            
            actionSheet.popoverPresentationController?.sourceView = view
            
            if UIDevice.current.userInterfaceIdiom == .pad { //디바이스 타입이 iPad일때
              
                  // ActionSheet가 표현되는 위치를 저장해줍니다.

                 
                  actionSheet.popoverPresentationController?.sourceRect =  CGRect(x: self.view.bounds.midX, y: self.view.bottom, width: 0, height: 0)
                actionSheet.popoverPresentationController?.permittedArrowDirections = []
                  self.present(actionSheet, animated: true, completion: nil)
              
            } else {
                actionSheet.popoverPresentationController?.sourceRect = view.bounds
              self.present(actionSheet, animated: true, completion: nil)
            }


       
          
    

            break
        default :
            self.tabBarController?.tabBar.isHidden = false
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 각 섹션 별 높이
        switch indexPath.section {
        case 0 :
            return 327
        case 1:
            return 178
        default:
            return 54
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0 :
            // 첫 번째 섹션과 두 번째 섹션 사이 값 0
            return 0
        case 6:
            // 마지막 섹션 값 130
            return 130
        default:
            return 12
        }
        
     
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    
        switch section {

        case 0:
            // 첫 번째 섹션과 두 번째 섹션 사이 값 0
            return UIView()
        default:
            let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 12))
            footer.backgroundColor = UIColor.appColor(.tableViewFooterColor)
            return footer
        }

       
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            
        }
    }
 
    
}
//MARK : MyPageUserInfoTVC Delegate
extension MyPageVC : MyPageUserInfoTVCDelegate{
    func didTapIcoButton() {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationPushViewController(storyboard: "IcoLevelSB", identifier: "IcoLevelVC")
    }
    
    
}

//MARK : 좋아요 뷰
extension MyPageVC {
    func setLikeViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapLikeView))
        viewTap.cancelsTouchesInView = false
        likeView.addGestureRecognizer(viewTap)
    }
    @objc func didTapLikeView(){
        
        self.navigationPushViewController(storyboard: "LikeSB", identifier: "LikeVC")
    }
}

//MARK : 알림 뷰
extension MyPageVC {
    func setAlarmViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapAlarmView))
        viewTap.cancelsTouchesInView = false
        alarmView.addGestureRecognizer(viewTap)
    }
    @objc func didTapAlarmView(){
        let storyboard = UIStoryboard(name: "AlarmSB", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AlarmVC") as! AlarmVC
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.complition = { taped in
            self.tabBarController?.selectedIndex = 1
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func alarmConfigure(){
        guard let jwtToken = self.jwtToken else{
            return
        }
        BaseManager.shared.getUserNewAlarm(jwtToken: jwtToken) { [weak self] response in
            guard let response = response else {
                return
            }
            if response == 0{
                self?.alarmIcon.image = UIImage(named: "icAlram1")
                self?.alarmIconWidth.constant = 24
                self?.alarmIconHeight.constant = 24
            }else if response == 1{
                self?.alarmIcon.image = UIImage(named: "icAlarmOn1")
                self?.alarmIconWidth.constant = 40
                self?.alarmIconHeight.constant = 40
            }
        }
    }
}
extension MyPageVC: MypageMyRecentStyleShotTVCDelegate{
    func didTapEachCells(styleShotIdx: Int) {
        let styleDetailSB = UIStoryboard(name: "StyleDetail", bundle: nil)
        let styleDetailVC = styleDetailSB.instantiateViewController(withIdentifier: "StyleDetailVC")as! StyleDetailVC
        styleDetailVC.isMine = true
        styleDetailVC.styleShotIdx = styleShotIdx
        self.navigationController?.pushViewController(styleDetailVC, animated: true)
    }
  
    
    
    
}
extension MyPageVC{
    @objc func refresh(){
        self.fetchData()

    }
    
     func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if (refreshControl.isRefreshing) {
                self.fetchData()
                self.refreshControl.endRefreshing()
                
            }
    }
}
extension MyPageVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
