//
//  MyPageVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//

import UIKit

class MyPageVC: BaseViewController {
    // MARK: - Properties
    
    private var featureModels = [
                "",
                "",
                "서비스 이용 약관",
                "알림 설정",
                "의견 보내기",
                "로그아웃",
                ""
            
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableviewConfigure()
    }
    

   

}

// MARK: - TableView Configure
extension MyPageVC {
    func tableviewConfigure(){
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
        switch indexPath.section{
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: MyPageUserInfoTVC.identifier, for: indexPath) as! MyPageUserInfoTVC
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: MypageMyRecentStyleShotTVC.identifier, for: indexPath) as! MypageMyRecentStyleShotTVC
            cell.selectionStyle = .none
          
            return cell
        case 6 :
            let cell = tableView.dequeueReusableCell(withIdentifier: IcoVerTVC.identifier, for: indexPath) as! IcoVerTVC
            cell.selectionStyle = .none
          
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: MypageTVC.identifier, for: indexPath) as! MypageTVC
            
            cell.featureLabel.text = featureModels[indexPath.section]
            return cell
     
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 2:
            // 서비스 이용 약관
            self.navigationPushViewController(storyboard: "ServiceTermsSB", identifier: "ServiceTermsVC")
            break
        case 3:
            // 알림 설정
            self.navigationPushViewController(storyboard: "SettingAlarmSB", identifier: "SettingAlarmVC")
            break
        case 4:
            // 의견 보내기
            self.navigationPushViewController(storyboard: "FeedbackSB", identifier: "FeedbackVC")
            break
        case 5:
            // 로그아웃
            UserDefaults.standard.set(nil, forKey: "jwtToken")
            let loginStoryboard = UIStoryboard(name: "LoginSB", bundle: nil)
            let loginVC = loginStoryboard.instantiateViewController(identifier: "LoginVC")
            loginVC.navigationItem.largeTitleDisplayMode = .never
            let vc = UINavigationController(rootViewController: loginVC)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            break
        default : break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 각 섹션 별 높이
        switch indexPath.section {
        case 0 :
            return 309
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

 
    
}
//MARK : MyPageUserInfoTVC Delegate
extension MyPageVC : MyPageUserInfoTVCDelegate{
    func didTapIcoButton() {
        self.navigationPushViewController(storyboard: "IcoLevelSB", identifier: "IcoLevelVC")
    }
    
    
}

