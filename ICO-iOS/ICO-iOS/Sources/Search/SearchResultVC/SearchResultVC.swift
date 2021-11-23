//
//  SearchResultVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

class SearchResultVC: BaseViewController {
    // MARK: - Properties
    var searchword = ""
    private var sortedIdx = 1
    private var searchResultModel : SearchResultResult?
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.attributedPlaceholder = NSAttributedString(string: "검색할 스타일샷의 키워드를 입력해 주세요.", attributes: [.foregroundColor: UIColor.primaryBlack50])
        
        searchTextField.text = searchword
        
        fetchData(sortedIdx: self.sortedIdx)
        collectionViewConfigure()
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
        self.searchword = text
        guard let jwtToken = self.jwtToken else{
            return
        }
        
        SearchResultManager.shared.getSearchResult(keyword: text, filter: "\(self.sortedIdx+1)", jwtToken: jwtToken) { [weak self] response in
            guard let response = response else {
                return
            }
            self?.searchResultModel = response
            self?.collectionView.reloadData()
        }
        
    }
    

}
// MARK: - FetchData
extension SearchResultVC{
    func fetchData(sortedIdx : Int){
        guard let jwtToken = self.jwtToken else{
            return
        }
        SearchResultManager.shared.getSearchResult(keyword: self.searchword, filter: "\(sortedIdx)", jwtToken: jwtToken) { [weak self] response in
            guard let response = response else {
                return 
            }
            self?.searchResultModel = response
            self?.collectionView.reloadData()
        }
    }
}
// MARK: - Configure CollecctionView
extension SearchResultVC {
    func collectionViewConfigure(){
        collectionView.backgroundColor = .white
        let resultCountCVCNib = UINib(nibName: ResultCountCVC.identifier, bundle: nil)
        collectionView.register(resultCountCVCNib, forCellWithReuseIdentifier: ResultCountCVC.identifier)
        
        let resultSortCVCNib = UINib(nibName: ResultSortCVC.identifier, bundle: nil)
        collectionView.register(resultSortCVCNib, forCellWithReuseIdentifier: ResultSortCVC.identifier)
        
        let searchResultsCVCNib = UINib(nibName: SearchResultsCVC.identifier, bundle: nil)
        collectionView.register(searchResultsCVCNib, forCellWithReuseIdentifier: SearchResultsCVC.identifier)

        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
// MARK: - CollectionView Delegate, DataSource
extension SearchResultVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 2 {
            return searchResultModel?.resultCnt ?? 0
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCountCVC.identifier, for: indexPath) as! ResultCountCVC
            if let resultCount = self.searchResultModel?.resultCnt{
                cell.searchResultCountLabel.text = "\(resultCount)건"
            }
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultSortCVC.identifier, for: indexPath) as! ResultSortCVC
            cell.delegate = self
            
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultsCVC.identifier, for: indexPath) as! SearchResultsCVC
            if let searchResult = self.searchResultModel?.seachResult{
                cell.getData(data: searchResult[indexPath.row].category)
                cell.configure(with: SearchResultsCVCViewModel(with: searchResult[indexPath.row]))
            }
            
            return cell
            
            
        default:
            return UICollectionViewCell()
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if indexPath.section == 2{
            if let searchResultModel = self.searchResultModel?.seachResult{
                if self.nickName == searchResultModel[indexPath.row].nickname {

                    pushToStyleShot(isMine: true, styleShotIdx: searchResultModel[indexPath.row].styleshotIdx)
                }else{
              
                    pushToStyleShot(isMine: false, styleShotIdx: searchResultModel[indexPath.row].styleshotIdx)
                }
            }
        }
       
        
       
       
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section{
        case 0:
            
            return CGSize(width: view.width-32, height: 46)
        case 1:
            
            return CGSize(width: view.width-32, height: 64)
        case 2:
            
            return CGSize(width: 164, height: 248)
        default :
            return CGSize()
        }
        
    }
 
    
    func pushToStyleShot(isMine : Bool,styleShotIdx : Int){
        let styleDetailSB = UIStoryboard(name: "StyleDetail", bundle: nil)
        let styleDetailVC = styleDetailSB.instantiateViewController(withIdentifier: "StyleDetailVC")as! StyleDetailVC
        styleDetailVC.isMine = isMine
        styleDetailVC.styleShotIdx = styleShotIdx
        self.navigationController?.pushViewController(styleDetailVC, animated: true)
    }
}
// MARK: - TextField Delegate
extension SearchResultVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text{
            if text == ""{
                self.presentAlert(title: "검색어를 입력해주세요.")
            }else{
                self.searchword = text
                if let jwtToken = UserDefaults.standard.string(forKey: "jwtToken"){
                    SearchResultManager.shared.getSearchResult(keyword: text, filter: "\(self.sortedIdx+1)", jwtToken: jwtToken) { [weak self] response in
                        guard let response = response else {
                            return
                        }
                        self?.searchResultModel = response
                        self?.collectionView.reloadData()
                    }
                }
            }
        }
        
        
        
        
        return true
    }
}
extension SearchResultVC : ResultSortCVCDelegate{
    func didTapSort(sortedIdx: Int) {
        self.sortedIdx = sortedIdx
        self.fetchData(sortedIdx: sortedIdx+1)
    }
    
    
}
