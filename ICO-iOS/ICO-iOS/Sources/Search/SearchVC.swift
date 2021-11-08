//
//  SearchVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/07.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableviewConfigure()
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
 

}
// MARK: - TableView Configure
extension SearchVC {
    func tableviewConfigure(){
        let topNib = UINib(nibName: RecentSearchWordsTVC.identifier, bundle: nil)
        tableView.register(topNib, forCellReuseIdentifier: RecentSearchWordsTVC.identifier)
        
        let sensitiveNib = UINib(nibName: HotKeywordTVC.identifier, bundle: nil)
        tableView.register(sensitiveNib, forCellReuseIdentifier: HotKeywordTVC.identifier)
        

        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = nil
        tableView.sectionHeaderHeight = 0
        tableView.separatorStyle = .none

    }
}
// MARK: - TableView Delegate, DataSource
extension SearchVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchWordsTVC.identifier, for: indexPath) as! RecentSearchWordsTVC
            cell.selectionStyle = .none
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: HotKeywordTVC.identifier, for: indexPath) as! HotKeywordTVC
            cell.selectionStyle = .none
            return cell

        default:
            return UITableViewCell()
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 2 :
            
            return 24
        default:
            return UITableView.automaticDimension
        }
  
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       
        switch section {
        case 2 :
            // 광고 배너 높이 조절
            return 70
        default:
            return 12
        }
     
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    
        switch section {
        case 2 :
            // 광고 배너 높이 조절
            let footer = UIImageView(frame: CGRect(x: 0, y: 0, width: view.width, height: 70))
            footer.image = UIImage(named: "img_search_banner")
            return footer
        default:
            let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 12))
            footer.backgroundColor = UIColor.appColor(.tableViewFooterColor)
            return footer
        }
       
    }
    
 
    
}
