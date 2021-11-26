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
    var isStart = false
    private var sortedIdx = 1
    private var searchResultModel : SearchResultResult?
    private var searchResultData = [SeachResultData]()
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var deleteButton: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.attributedPlaceholder = NSAttributedString(string: "검색할 스타일샷의 키워드를 입력해 주세요.", attributes: [.foregroundColor: UIColor.primaryBlack50,.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 14)])
        
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
            guard let response = response, let result = response.seachResult else {
                return
            }
            print(result)
            self?.searchResultModel = response
            self?.searchResultData = result
            self?.isStart = false
            self?.collectionView.reloadData()
            self?.isStart = true
        }
        
    }
    @IBAction func didTapDeleteButton(_ sender: Any) {
        searchTextField.text = ""
    }
    

}
// MARK: - FetchData
extension SearchResultVC{
    func fetchData(sortedIdx : Int){
        guard let jwtToken = self.jwtToken else{
            return
        }
        SearchResultManager.shared.getMoreSearchResult(pagination: false, lastIndex: 0, filter: "\(sortedIdx)", keyword: self.searchword, jwtToken: jwtToken) { [weak self] response in
            guard let response = response else {
                return
            }
            
            self?.searchResultData = response
            self?.collectionView.reloadData()
            self?.isStart = true
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
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
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
            return searchResultData.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCountCVC.identifier, for: indexPath) as! ResultCountCVC
                cell.searchResultCountLabel.text = "\(searchResultData.count)건"
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultSortCVC.identifier, for: indexPath) as! ResultSortCVC
            cell.delegate = self
            
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultsCVC.identifier, for: indexPath) as! SearchResultsCVC
                cell.getData(data: searchResultData[indexPath.row].category)
                cell.configure(with: SearchResultsCVCViewModel(with: searchResultData[indexPath.row]))

            
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
    // 페이징
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffY = scrollView.contentOffset.y
        
        if contentOffY >= (collectionView.contentSize.height+150-scrollView.frame.size.height){
            guard let jwtToken = self.jwtToken, isStart else{
                return
            }
            guard !SearchResultManager.shared.isPaginating else{
                return
            }
           
            SearchResultManager.shared.getMoreSearchResult(pagination: true, lastIndex: self.searchResultData.count, filter: "\(self.sortedIdx+1)", keyword: self.searchword , jwtToken: jwtToken) { [weak self] response in
                guard let response = response else {
                    return
                }
                self?.searchResultData.append(contentsOf: response)
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    
}
// MARK: - TextField Delegate
extension SearchResultVC : UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.deleteButton.isHidden = false
        guard let text = textField.text, text.isExists else{
            self.deleteButton.isHidden = true
            return
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text{
            if text == ""{
                self.presentAlert(title: "검색어를 입력해주세요.")
            }else{
                self.searchword = text
                if let jwtToken = UserDefaults.standard.string(forKey: "jwtToken"){
                    SearchResultManager.shared.getSearchResult(keyword: text, filter: "\(self.sortedIdx+1)", jwtToken: jwtToken) { [weak self] response in
                        guard let response = response, let result = response.seachResult else {
                            return
                        }
                        self?.searchResultModel = response
                        self?.searchResultData = result
                        self?.isStart = false
                        self?.collectionView.reloadData()
                        self?.isStart = true
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
