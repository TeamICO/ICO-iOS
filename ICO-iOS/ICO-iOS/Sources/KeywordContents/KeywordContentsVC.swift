//
//  KeywordContentsVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/23.
//

import UIKit

class KeywordContentsVC: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    var index = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkInternet()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableviewConfigure()
        
    }
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
 
}
// MARK: - TableView Configure
extension KeywordContentsVC {
    func tableviewConfigure(){
        let topTVCNib = UINib(nibName: KeywordContentsTopTVC.identifier, bundle: nil)
        tableView.register(topTVCNib, forCellReuseIdentifier: KeywordContentsTopTVC.identifier)
        
        let keywordContentsTVCNib = UINib(nibName: KeywordContentsTVC.identifier, bundle: nil)
        tableView.register(keywordContentsTVCNib, forCellReuseIdentifier: KeywordContentsTVC.identifier)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = nil
        tableView.sectionHeaderHeight = 0
        tableView.separatorStyle = .none

    }
}
// MARK: - TableView Delegate, DataSource
extension KeywordContentsVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return 3
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: KeywordContentsTopTVC.identifier, for: indexPath) as! KeywordContentsTopTVC
            cell.configure(index: self.index)
            return cell
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: KeywordContentsTVC.identifier, for: indexPath) as! KeywordContentsTVC
            cell.configure(index: indexPath.row,cellIndex: self.index)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1{
            return 0
        }else{
            return 12
        }
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1{
            return UIView()
        }else{
            let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 12))
            footer.backgroundColor = UIColor.appColor(.tableViewFooterColor)
            return footer
        }
       
    }
}
