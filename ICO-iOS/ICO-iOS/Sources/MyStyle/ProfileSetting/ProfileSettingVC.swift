//
//  ProfileSettingVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/10.
//

import UIKit

class ProfileSettingVC: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var updateView: UIView!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableviewConfigure()
        configure()
        
    }
   
    
    // MARK: - Selectors
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension ProfileSettingVC{
    // MARK: - Configure
    func configure(){
        updateView.setVerticalGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: .white)
        updateButton.layer.cornerRadius = 12
        updateButton.layer.masksToBounds = true
        updateButton.setGradient(color1: UIColor.appColor(.feedbackButtoncolor1), color2: UIColor.appColor(.feedbackButtoncolor2))
    }
}
// MARK: - TableView Configure
extension ProfileSettingVC {
    func tableviewConfigure(){
        let userInfoNib = UINib(nibName: ProfileUserInfoTVC.identifier, bundle: nil)
        tableView.register(userInfoNib, forCellReuseIdentifier: ProfileUserInfoTVC.identifier)
        
        let userIntroNib = UINib(nibName: ProfileUserIntroductionTVC.identifier, bundle: nil)
        tableView.register(userIntroNib, forCellReuseIdentifier: ProfileUserIntroductionTVC.identifier)
        
        
        let ecoKeywordNib = UINib(nibName: ProfileMyEcoKeywordTVC.identifier, bundle: nil)
        tableView.register(ecoKeywordNib, forCellReuseIdentifier: ProfileMyEcoKeywordTVC.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = nil
        tableView.sectionHeaderHeight = 0
        tableView.separatorStyle = .none

    }
}
// MARK: - TableView Delegate, DataSource
extension ProfileSettingVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileUserInfoTVC.identifier, for: indexPath) as! ProfileUserInfoTVC
            cell.selectionStyle = .none
           
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileUserIntroductionTVC.identifier, for: indexPath) as! ProfileUserIntroductionTVC
            cell.selectionStyle = .none
            
            return cell
        case 2 :
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileMyEcoKeywordTVC.identifier, for: indexPath) as! ProfileMyEcoKeywordTVC
            cell.selectionStyle = .none
            
            return cell
        default:
            return UITableViewCell()
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0 : return 192
        case 1 : return 157
        case 2 : return 342
        default : return 0
        }
       
    }


    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        switch section {
        case 2 : return UIView()
        default :
            let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 12))
            footer.backgroundColor = UIColor.appColor(.tableViewFooterColor)
            return footer
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 2 : return 0
        default : return 12
        }
    }

    
    
}
