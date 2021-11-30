//
//  AlarmVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/11.
//

import UIKit

class AlarmVC: BaseViewController {
    // MARK: - Propertices
    private let sections = ["","오늘","이전 알림"]
    
    public var complition : ((Bool)->Void)?
    
    private var todayAlarms = [Alarms]()
    private var previouseAlarms = [Alarms]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    private var refreshControl = UIRefreshControl()
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableviewConfigure()
        fetchData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setBlurEffect(view: topView)
    }
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
// MARK: - FetchData
extension AlarmVC{
    func fetchData(){
        guard let jwtToken = self.jwtToken else{
            return
        }
        AlarmManager.shared.getUserAlarms(jwtToken: jwtToken) { [weak self] response in
            guard let today = response.today, let previouse = response.previous else {
                return
            }
            self?.todayAlarms = today
            self?.previouseAlarms = previouse
            self?.tableView.reloadData()
        }
    }
}
// MARK: - TableView Configure
extension AlarmVC {
    func tableviewConfigure(){
        refreshControl.alpha = 0
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        let todayNib = UINib(nibName: TodayAlarmTVC.identifier, bundle: nil)
        tableView.register(todayNib, forCellReuseIdentifier: TodayAlarmTVC.identifier)
        
        let beforeNib = UINib(nibName: BeforeAlarmTVC.identifier, bundle: nil)
        tableView.register(beforeNib, forCellReuseIdentifier: BeforeAlarmTVC.identifier)
        
        
        let noneAlarmNib = UINib(nibName: NoneAlarmTVC.identifier, bundle: nil)
        tableView.register(noneAlarmNib, forCellReuseIdentifier: NoneAlarmTVC.identifier)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = nil
        tableView.sectionFooterHeight = 0
        tableView.separatorStyle = .none

    }
}
// MARK: - TableView Delegate, DataSource
extension AlarmVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if todayAlarms.isEmpty && previouseAlarms.isEmpty{
            return 1
        }else{
            return  sections.count
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if todayAlarms.isEmpty && previouseAlarms.isEmpty{
            return 1
        }else{
            switch section{
            case 1 : return todayAlarms.count
            case 2 : return previouseAlarms.count
            default :
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.appColor(.tableViewCellColor)
        
        
        if todayAlarms.isEmpty && previouseAlarms.isEmpty{
            let cell = tableView.dequeueReusableCell(withIdentifier: NoneAlarmTVC.identifier, for: indexPath) as! NoneAlarmTVC
            cell.selectionStyle = .none
            tableView.isScrollEnabled = false
            return cell
        }else{
            switch indexPath.section{
            case 1 :
                let cell = tableView.dequeueReusableCell(withIdentifier: TodayAlarmTVC.identifier, for: indexPath) as! TodayAlarmTVC
                cell.selectedBackgroundView =  bgColorView
                cell.configure(with: AlarmViewModel(with: todayAlarms[indexPath.row]))
                return cell
            case 2 :
                let cell = tableView.dequeueReusableCell(withIdentifier: BeforeAlarmTVC.identifier, for: indexPath) as! BeforeAlarmTVC
                cell.selectedBackgroundView =  bgColorView
                cell.configure(with: AlarmViewModel(with: previouseAlarms[indexPath.row]))
                return cell

            default:
                return UITableViewCell()
            }
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !todayAlarms.isEmpty || !previouseAlarms.isEmpty{
            guard let jwtToken = self.jwtToken else{
                return
            }
            
            switch indexPath.section{
            case 1:
                let alarm = todayAlarms[indexPath.row]
                if alarm.isNew == 1 {
                    AlarmManager.shared.readAlarm(type: alarm.type,
                                                  notificationIdx: alarm.notificationIdx,
                                                  jwtToken: jwtToken) { [weak self] success in
                        guard success else{
                            return
                        }
                   
                        DispatchQueue.main.async {
                            self?.fetchData()
                        }
                    }
                }
                
                self.didTapAlarm(type: alarm.type)
                
                break
            case 2:
                let alarm = previouseAlarms[indexPath.row]
                if alarm.isNew == 1 {
                    AlarmManager.shared.readAlarm(type: alarm.type,
                                                  notificationIdx: alarm.notificationIdx,
                                                  jwtToken: jwtToken) { [weak self]success in
                        guard success else{
                            return
                        }
             
                        DispatchQueue.main.async {
                            self?.fetchData()
                        }
                    }
                }
                self.didTapAlarm(type: alarm.type)
             
                break
            default :
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if todayAlarms.isEmpty && previouseAlarms.isEmpty{
            return 500
        }else{
            if indexPath.section == 0 {
                return 0
            }else{
                return 90
            }
        }
       
        
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if todayAlarms.isEmpty && previouseAlarms.isEmpty{
            return 70
        }else{
            return 54
        }
       
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if todayAlarms.isEmpty && previouseAlarms.isEmpty{
            let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 70))
            
            return header
        }else{
            
            // 섹션 뷰 셋팅
            let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 54))
            let label = UILabel(frame: CGRect(x: 16, y: 16, width: view.width-32, height: 28))
            label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
            label.text = sections[section]
            header.addSubview(label)
            header.backgroundColor = .white
            return header
        }
       
    }

    func didTapAlarm(type : String){
        switch type{
        case "url" :
            break
        case "styleshotIdx" :
            self.navigationController?.popViewController(animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now()+0.05) {
                self.complition?(true)
            }
            break
        case "like" :
            self.navigationController?.popViewController(animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now()+0.05) {
                self.complition?(true)
            }
            break
        case "mypage":
            let storyboard = UIStoryboard(name: "LevelUpSB", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "LevelUpVC") as! LevelUpVC
            vc.navigationItem.largeTitleDisplayMode = .never
            vc.completion = { taped in
                self.tabBarController?.selectedIndex = 2
            }
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        default:
            break
        }
    }
    
    
}
extension AlarmVC{
    @objc func refresh(){
            

    }
    
     func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if (refreshControl.isRefreshing) {
                self.fetchData()
                self.refreshControl.endRefreshing()
                
            }
    }
}
