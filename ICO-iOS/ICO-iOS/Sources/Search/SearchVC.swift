//
//  SearchVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/07.
//

import UIKit

class SearchVC: BaseViewController {
    // MARK: - Properties
    private var searchModel : SearchResult?
    private var searchKeywords = [String]()
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var searchKeywordTableView: UITableView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.attributedPlaceholder = NSAttributedString(string: "검색할 스타일샷의 키워드를 입력해 주세요.", attributes: [.foregroundColor: UIColor.primaryBlack50])
        self.dismissKeyboardWhenTappedAround()
        self.tableviewConfigure()
        self.searchKeywordTableviewConfigure()
        
        searchTextField.delegate = self
    }
    // MARK: - Selectors
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapSearchButton(_ sender: Any) {
        guard let text = searchTextField.text, text.isExists else{
            self.presentAlert(title: "검색어를 입력해주세요.")
            return
        }
        guard text.count <= 20 else{
            self.presentAlert(title: "글자 수를 초과하였습니다.")
            return
        }
        let storyboard = UIStoryboard(name: "SearchResultSB", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SearchResultVC") as! SearchResultVC
        vc.searchword = text
        vc.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.pushViewController(vc, animated: true)
        searchTextField.text = ""
    }
    @IBAction func didTapDeleteButton(_ sender: Any) {
        searchTextField.text = ""
    }
    

}
// MARK: - FetchData
extension SearchVC {
    func fetchData(){
        guard let jwtToken = self.jwtToken else{
            return
        }
        SearchManager.shared.getSearchKeywordHistory(jwtToken: jwtToken) { [weak self] response in
            guard let response = response else {
                return
            }
            self?.searchModel = response
            self?.tableView.reloadData()
        }
    }
}
// MARK: - TableView Configure
extension SearchVC {
    func searchKeywordTableviewConfigure(){
        let topNib = UINib(nibName: SearchKeywordTVC.identifier, bundle: nil)
        searchKeywordTableView.register(topNib, forCellReuseIdentifier: SearchKeywordTVC.identifier)
   
        searchKeywordTableView.backgroundColor = .black.withAlphaComponent(0.2)
        searchKeywordTableView.delegate = self
        searchKeywordTableView.dataSource = self
        searchKeywordTableView.tableFooterView = nil
        searchKeywordTableView.sectionFooterHeight = 0
        searchKeywordTableView.separatorStyle = .none

    }
}
// MARK: - TableView Configure
extension SearchVC {
    func tableviewConfigure(){
        let topNib = UINib(nibName: RecentSearchWordsTVC.identifier, bundle: nil)
        tableView.register(topNib, forCellReuseIdentifier: RecentSearchWordsTVC.identifier)
        
        let sensitiveNib = UINib(nibName: HotKeywordTVC.identifier, bundle: nil)
        tableView.register(sensitiveNib, forCellReuseIdentifier: HotKeywordTVC.identifier)
   
        tableView.backgroundColor = .white
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
        switch tableView {
        case searchKeywordTableView:
            return 1
        case self.tableView:
            return 2
        default:
            return 0
        }
        
        
    
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case searchKeywordTableView:
            return searchKeywords.count
        case self.tableView:
            return 1
        default:
            return 0
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        switch tableView {
        case searchKeywordTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchKeywordTVC.identifier, for: indexPath) as! SearchKeywordTVC
            cell.keywordLabel.text = searchKeywords[indexPath.row]
            return cell
        case self.tableView:
            switch indexPath.section{
            case 0 :
                let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchWordsTVC.identifier, for: indexPath) as! RecentSearchWordsTVC
                cell.selectionStyle = .none
                cell.delegate = self
                if let model = self.searchModel{
                    cell.getData(data: model.keywordHistory)
                }
                
                return cell
                
            case 1 :
                let cell = tableView.dequeueReusableCell(withIdentifier: HotKeywordTVC.identifier, for: indexPath) as! HotKeywordTVC
                cell.selectionStyle = .none
                return cell
                
            default:
                
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
            
        
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case searchKeywordTableView:
            return 38
        case self.tableView:
            switch indexPath.section {
            case 1 :  return 264
            default:
                return UITableView.automaticDimension
            }
        default:
            return 0
        }
            
           
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

        switch tableView {
        case searchKeywordTableView:
            return 0
        case self.tableView:
            switch section {
            case 1 :
                // 광고 배너 높이 조절
                return 94
            default:
                return 12
            }
        default:
            return 0
        }
           
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        switch tableView {
        case searchKeywordTableView:
            return UIView()
        case self.tableView:
            switch section {
            case 1 :
                // 광고 배너 높이 조절
                let footer =  UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 94))
                let imageview = UIImageView(frame: CGRect(x: 0, y: 24, width: footer.width, height: 70))
                if let url = self.searchModel?.bannerImageURL{
                    imageview.setImage(with: url)
                }
                footer.backgroundColor = .white
                footer.addSubview(imageview)
                return footer
            default:
                let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 12))
                footer.backgroundColor = UIColor.appColor(.tableViewFooterColor)
                return footer
            }
        default:
            return UIView()
        }
           
        
        
    }
    
 
    
}
// MARK: - TextField Delegate
extension SearchVC : UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.deleteButton.isHidden = false
        self.searchKeywordTableView.isHidden = false
        guard let jwtToken = self.jwtToken, let keyword = textField.text, keyword.isExists else{
            self.deleteButton.isHidden = true
            self.searchKeywordTableView.isHidden = true
            return
        }
        SearchManager.shared.getSearchAutocompleteWords(keyword: keyword, jwtToken: jwtToken) { [weak self] response in
            guard let result = response.result else{
                return
            }
            self?.searchKeywords = result
            self?.searchKeywordTableView.reloadData()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchKeywordTableView.isHidden = true
        if let text = textField.text{
            if text == ""{
                self.presentAlert(title: "검색어를 입력해주세요.")
            }else{
                guard text.count <= 20 else{
                    self.presentAlert(title: "글자 수를 초과하였습니다.")
                    return true
                }
                let storyboard = UIStoryboard(name: "SearchResultSB", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "SearchResultVC") as! SearchResultVC
                vc.searchword = text
                vc.navigationItem.largeTitleDisplayMode = .never
                self.navigationController?.pushViewController(vc, animated: true)
                searchTextField.text = ""
            }
        }
        return true
    }
}
extension SearchVC : RecentSearchWordsTVCDelegate{
    
    func didTapSearchKeyword(keyword: String) {
        let storyboard = UIStoryboard(name: "SearchResultSB", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SearchResultVC") as! SearchResultVC
        vc.searchword = keyword
        vc.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
