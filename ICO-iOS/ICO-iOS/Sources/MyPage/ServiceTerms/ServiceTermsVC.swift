//
//  ServiceTermsVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

class ServiceTermsVC: UIViewController {

    private let models = [
            "개인정보처리방침",
            "서비스 이용 약관",
            ""
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableviewConfigure()
    }
    

    @IBAction func didTabpBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapHomeButton(_ sender: Any) {
        
    }
    
}
// MARK: - TableView Configure
extension ServiceTermsVC {
    func tableviewConfigure(){
        let IcoLevelTopTVCNib = UINib(nibName: ServiceTermsTVC.identifier, bundle: nil)
        tableView.register(IcoLevelTopTVCNib, forCellReuseIdentifier: ServiceTermsTVC.identifier)

   
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = nil
        tableView.sectionFooterHeight = 0
        tableView.separatorStyle = .none

    }
}
// MARK: - TableView Delegate, DataSource
extension ServiceTermsVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 2 :
            // 하단 여백 셀
            return UITableViewCell()
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: ServiceTermsTVC.identifier, for: indexPath) as! ServiceTermsTVC
            cell.titleLabel.text = models[indexPath.section]
            
            return cell
        }
      
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0 :
            self.navigationPushViewController(storyboard: "PersonalInfoTermsSB", identifier: "PersonalInfoTermsVC")
            break
        case 1 : break
        default : break
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 2 : return 0 // 하단 여백 셀 높이
        default : return 54
        }
     
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 12))
        footer.backgroundColor = UIColor.appColor(.tableViewFooterColor)
        return footer
       
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 2 : return view.height // 하단 여백 섹션 높이
        default : return 12
        }
    }
    
    
}
