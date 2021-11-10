//
//  SearchResultVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

class SearchResultVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewConfigure()
        searchTextField.delegate = self
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func didTapSearchButton(_ sender: Any) {
        guard let text = searchTextField.text, text.isExists else{
            self.presentAlert(title: "검색어를 입력해주세요.")
            return
        }
    }
    

}
// MARK: - Configure CollecctionView
extension SearchResultVC {
    func collectionViewConfigure(){
        
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
            return 10
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCountCVC.identifier, for: indexPath) as! ResultCountCVC
      
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultSortCVC.identifier, for: indexPath) as! ResultSortCVC
     
            
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultsCVC.identifier, for: indexPath) as! SearchResultsCVC
            
            
            return cell
            
            
        default:
            return UICollectionViewCell()
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section{
        case 0:
            
            return CGSize(width: view.width, height: 46)
        case 1:
            
            return CGSize(width: view.width, height: 64)
        case 2:
            
            return CGSize(width: view.width/2, height: 238)
        default :
            return CGSize()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      
        return 24
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return -15
    }
    
    
}
// MARK: - TextField Delegate
extension SearchResultVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text{
            if text == ""{
                self.presentAlert(title: "검색어를 입력해주세요.")
            }else{
  
            }
        }
        
        
        
        
        return true
    }
}
