//
//  LikeVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/11.
//

import UIKit

class LikeVC: BaseViewController {

    private var likeResult = [LikeResult]()
   
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewConfigure()
        fetchData()
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
// MARK: - FetchData
extension LikeVC{
    func fetchData(){
        guard let jwtToken = self.jwtToken else{
            return
        }
        LikeManger.shared.getUserLikes(jwtToken: jwtToken) { [weak self] response in
            guard let response = response else {
                return
            }
            self?.likeResult = response
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - CollectionView Configure
extension LikeVC {
    func collectionViewConfigure(){
      

        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: LikeCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: LikeCVC.identifier)
        let noneLikenib = UINib(nibName: NoneLikeCVC.identifier, bundle: nil)
        collectionView.register(noneLikenib, forCellWithReuseIdentifier: NoneLikeCVC.identifier)
        
    }
}
extension LikeVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.likeResult.isEmpty{
            return 1
        }else{
            return likeResult.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.likeResult.isEmpty{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoneLikeCVC.identifier, for: indexPath) as! NoneLikeCVC
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikeCVC.identifier, for: indexPath) as! LikeCVC
            cell.configure(with: LikeCVCViewModel(with: self.likeResult[indexPath.row]))
            cell.getData(data: likeResult[indexPath.row].category)
            return cell
        }
       
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
      
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.likeResult.isEmpty {
            collectionView.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
            return CGSize(width: view.width, height: 500)
        }else{
            collectionView.contentInset = UIEdgeInsets(top: 70, left: 16, bottom: 0, right: 16)
            return CGSize(width: view.width/2-28, height: 238)
        }
       
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if self.likeResult.isEmpty {
            return 0
        }else{
            return 24
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
