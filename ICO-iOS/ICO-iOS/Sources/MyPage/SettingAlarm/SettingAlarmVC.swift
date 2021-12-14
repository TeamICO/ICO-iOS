//
//  SettingAlarmVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

class SettingAlarmVC: BaseViewController {

    private let models = [
                "",
                "마케팅 수신 알림",
                "나의 스타일샷 알림"
    ]
    public var complition : ((Bool)->Void)?
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableviewConfigure()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setBlurEffect(view: topView)
    }


    @IBAction func didTabpBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapHomeButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            self.complition?(true)
        }
    }
    
}

// MARK: - TableView Configure
extension SettingAlarmVC {
    func tableviewConfigure(){
        let userAlarmSettingTVCNib = UINib(nibName: UserAlarmSettingTVC.identifier, bundle: nil)
        tableView.register(userAlarmSettingTVCNib, forCellReuseIdentifier: UserAlarmSettingTVC.identifier)
        
        let settingAlarmTVCNib = UINib(nibName: SettingAlarmTVC.identifier, bundle: nil)
        tableView.register(settingAlarmTVCNib, forCellReuseIdentifier: SettingAlarmTVC.identifier)


        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = nil
        tableView.sectionFooterHeight = 0
        tableView.separatorStyle = .none
        // 네비게이션 pop 제스처
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

    }
}
// MARK: - TableView Delegate, DataSource
extension SettingAlarmVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingAlarmTVC.identifier, for: indexPath) as! SettingAlarmTVC
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
           
        
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: UserAlarmSettingTVC.identifier, for: indexPath) as! UserAlarmSettingTVC
            cell.titleLabel.text = models[indexPath.section]
            cell.delegate = self
            cell.index = indexPath.section
            return cell
           
        }
      
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0 :

            break
        default : break
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0 : return UITableView.automaticDimension
        default : return 70
        }
     
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            return UIView()
        }
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 12))
        footer.backgroundColor = UIColor.appColor(.tableViewFooterColor)
        return footer
       
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }
        return 12
    }
    
    
}
//MARK : SettingAlarmTVC Delegate
extension SettingAlarmVC : SettingAlarmTVCDelegate{
    func setUserAlarm() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.openURL(url)
        }
    }
    
    
}
extension SettingAlarmVC : UserAlarmSettingTVCDelelgate{
    func changeAlarm(index: Int, state: String) {
        print(index)
        guard let jwtToken = self.jwtToken else{
            return
        }
        switch index {
        case 1 :
            
            SettingAlarmManger.shared.updateUserAlarm(marketingAgree: state, styleAgree: nil, userIdx: self.userIdx, jwtToken: jwtToken)
            break
        case 2 :
            SettingAlarmManger.shared.updateUserAlarm(marketingAgree: nil, styleAgree: state, userIdx: self.userIdx, jwtToken: jwtToken)
            break
        default : break
        }
    }
    
    
}
extension SettingAlarmVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
