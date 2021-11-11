//
//  AlarmVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/11.
//

import UIKit

class AlarmVC: UIViewController {
    // MARK: - Propertices
    private let sections = ["","오늘","이전 알림"]
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableviewConfigure()
    }
    

    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
// MARK: - TableView Configure
extension AlarmVC {
    func tableviewConfigure(){
        let todayNib = UINib(nibName: TodayAlarmTVC.identifier, bundle: nil)
        tableView.register(todayNib, forCellReuseIdentifier: TodayAlarmTVC.identifier)
        
        let beforeNib = UINib(nibName: BeforeAlarmTVC.identifier, bundle: nil)
        tableView.register(beforeNib, forCellReuseIdentifier: BeforeAlarmTVC.identifier)
        
        
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
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.appColor(.tableViewCellColor)
        
        switch indexPath.section{
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: TodayAlarmTVC.identifier, for: indexPath) as! TodayAlarmTVC
            cell.selectedBackgroundView =  bgColorView
           
            return cell
        case 2 :
            let cell = tableView.dequeueReusableCell(withIdentifier: BeforeAlarmTVC.identifier, for: indexPath) as! BeforeAlarmTVC
            cell.selectedBackgroundView =  bgColorView
            
            return cell

        default:
            return UITableViewCell()
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0 : return 0 // 네비게이션 바 높이 조절을 위한 0번째 섹션 셀 높이
        default : return 90 //  실제 테이블 셀 높이
        }
        
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0 : return 54 // 네비게이션 바 높이 조절을 위한 0번째 섹션 값
        default : return 52 //  실제 테이블 섹션 높이
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 섹션 뷰 셋팅
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 12))
        let label = UILabel(frame: CGRect(x: 16, y: 12, width: view.width-32, height: 28))
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        label.text = sections[section]
        header.addSubview(label)
        header.backgroundColor = .white
        return header
    }


    
    
}
