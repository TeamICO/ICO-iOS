//
//  KeywordVC.swift
//  ICO
//
//  Created by 이은영 on 2021/11/03.
//

import UIKit
import Foundation
class KeywordVC: UIViewController {
    
    var isStart = false
    var isLast = false
    var keywordServerData: [RecentResult] = []
    var sortedIdx: Int = 1
    @IBOutlet weak var keywordCV: UICollectionView!
    @IBOutlet weak var postTV: UITableView!
    @IBOutlet weak var keywordScrollView: UIScrollView!
    @IBOutlet weak var entireHeight: NSLayoutConstraint!
    var serverArray: [Int] = []
    var serverArrayToString = ""
    
    var seletedArr = [false,false,false,false,false,false,false]
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var alertTitle: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData(Index: serverArrayToString)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerXib()
        keywordCV.delegate = self
        keywordCV.dataSource = self
        keywordCV.contentInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        keywordCV.allowsMultipleSelection = true
        keywordScrollView.delegate = self
        //처음 초기 세팅, 안내창 나오게 하고 키워드별 게시물 안나오도록
        emptyView.isHidden = false
        postTV.isHidden = true
        setEmpty()
    }

    func setTV(){
        postTV.delegate = self
        postTV.dataSource = self
    }
    
    func registerXib(){
        keywordCV.register(UINib(nibName: "KeywordCVC", bundle: nil), forCellWithReuseIdentifier: "KeywordCVC")
        postTV.register(UINib(nibName: "RecentTVC", bundle: nil), forCellReuseIdentifier: "RecentTVC")
        postTV.register(UINib(nibName: "EmptyKeywordTVC", bundle: nil), forCellReuseIdentifier: "EmptyKeywordTVC")
    }
    
    func setEmpty(){
        alertTitle.textColor = UIColor.alertsInfo
        alertTitle.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
        emptyView.layer.cornerRadius = 8
        emptyView.layer.borderWidth = 1
        emptyView.layer.borderColor = UIColor.primaryBlack20.cgColor
    }
    

}


extension KeywordVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let keywordCell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordCVC", for: indexPath)as? KeywordCVC else {return UICollectionViewCell()}
        
        
        keywordCell.sortedIdx = indexPath.row
        keywordCell.setUI(index: indexPath.row,isSeleted: self.seletedArr[indexPath.row])
        
        return keywordCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 32
        var width = 0
        
        if indexPath.row == 1 || indexPath.row == 6{
           width = 69
        }else if indexPath.row == 0 || indexPath.row == 2{
           width = 105
        }else if indexPath.row == 3{
            width = 118
        }else if indexPath.row == 5{
            width = 85
        }else{
            width = 100
        }
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.seletedArr[indexPath.row] = !self.seletedArr[indexPath.row]
        if self.seletedArr[indexPath.row]{
            serverArray.append(indexPath.row+1)
            serverArrayToString = serverArray.map({"\($0)"}).joined(separator: ",")
            fetchData(Index: serverArrayToString)
            print("서버 문자열은\(serverArrayToString)")
        }else{
            if let searchIndex = serverArray.firstIndex(of: indexPath.row+1){
                serverArray.remove(at: searchIndex)
                serverArrayToString = serverArray.map({"\($0)"}).joined(separator: ",")
                fetchData(Index: serverArrayToString)
            }
        }
        
        keywordCV.reloadData()
        postTV.reloadData()
        
        
        if serverArray.isEmpty{
            postTV.isHidden = true
            emptyView.isHidden = false
        }else{
            postTV.isHidden = false
            emptyView.isHidden = true
        }
    }


}

    
extension KeywordVC: UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate{
    
    func fetchData(Index:String){
        StyleLifeDataManager.shared.getKeywordInfo(pagination: false,lastIndex: 0, self, Index){ [weak self] response in
            guard let response = response else{
                return
            }
           
            self?.keywordServerData = response
            self?.postTV.reloadData()
            self?.setTV()
            
            if response.isEmpty{
                self?.postTV.isScrollEnabled = false
            }
            
            self?.isStart = true
            guard let cnt = self?.keywordServerData.count else{
                return
            }
           // print("데이터의 개수는 \(cnt)")
            self?.entireHeight.constant = CGFloat(200 + (cnt * 616))
           // print("-------------------")
            //print(self?.entireHeight.constant)
            //print("--------------------")
        }
       
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffY = scrollView.contentOffset.y
        if contentOffY >= (postTV.contentSize.height-3400-scrollView.frame.size.height){
           
            guard isStart == true else{
                return
            }
            
            guard !StyleLifeDataManager.shared.isKeywordPaginating else{
                return
            }
           
            guard !isLast else{
                return
            }
            StyleLifeDataManager.shared.getKeywordInfo(pagination: true, lastIndex: self.keywordServerData.count, self, serverArrayToString){[weak self] response in
                print("33333")
                guard let response = response else {
                    return
                }
                print(response)
                if response.isEmpty{
                    self?.isLast = true
                }
            
                self?.keywordServerData.append(contentsOf: response)
                self?.postTV.reloadData()
            }
            let cnt :Int = keywordServerData.count
           entireHeight.constant = CGFloat(200 + (cnt * 616))
        }
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        UIView.animate(withDuration: 0.5) { [weak self] in
                    guard velocity.y != 0 else { return }
                    if velocity.y < 0 {
                        let height = self?.tabBarController?.tabBar.frame.height ?? 0.0
                        self?.tabBarController?.tabBar.alpha = 1.0
                        self?.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY - height)
                    } else {
                    self?.tabBarController?.tabBar.alpha = 0.0
                        self?.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY)
                    }
                }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keywordServerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentTVC", for: indexPath)as? RecentTVC else {return UITableViewCell()}
       
        cell.selectionStyle = .none
        cell.mainImage.setImage(with: keywordServerData[indexPath.row].imageURL)
        cell.nameLabel.text = keywordServerData[indexPath.row].nickname
        cell.userImage.setImage(with: keywordServerData[indexPath.row].profileURL)
        if keywordServerData[indexPath.row].profileURL == ""{
            cell.userImage.image = UIImage(named: "img_profile_default")
        }
        cell.detailLabel.text = keywordServerData[indexPath.row].resultDescription
        cell.heartNum.text = "\(keywordServerData[indexPath.row].likeCnt)"
        cell.productName.text = keywordServerData[indexPath.row].productName
        var score1  = keywordServerData[indexPath.row].point
        cell.score.text = "\(score1).0"
        if cell.score.text == "5.0"{
            cell.ecoLevelImg.image = UIImage(named: "ic-styleshot-upload-ecolevel-5")
        }else if cell.score.text == "4.0"{
            cell.ecoLevelImg.image = UIImage(named: "ic-styleshot-upload-ecolevel-4")
        }else if cell.score.text == "3.0"{
            cell.ecoLevelImg.image = UIImage(named: "ic-styleshot-upload-ecolevel-3")
        }else if cell.score.text == "2.0"{
            cell.ecoLevelImg.image = UIImage(named: "ic-styleshot-upload-ecolevel-2")
        }else if cell.score.text == "1.0"{
            cell.ecoLevelImg.image = UIImage(named: "ic-styleshot-upload-ecolevel-1")
        }
        
        cell.time.text = keywordServerData[indexPath.row].time
        cell.setData(category: keywordServerData[indexPath.row].category)
        cell.heartCnt = keywordServerData[indexPath.row].likeCnt
        cell.styleShotIdx = keywordServerData[indexPath.row].styleshotIdx
        if keywordServerData[indexPath.row].isLike == 0{
            cell.heartBtn.setImage(UIImage(named: "icHeartUnclick1"), for: .normal)
            cell.isliked = false
        }else{
            cell.heartBtn.setImage(UIImage(named: "icHeartClick1"), for: .normal)
            cell.isliked = true
        }

        cell.delegate = self

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let styleDetailSB = UIStoryboard(name: "StyleDetail", bundle: nil)
        let styleDetailVC = styleDetailSB.instantiateViewController(withIdentifier: "StyleDetailVC")as! StyleDetailVC
        styleDetailVC.isMine = false
        styleDetailVC.styleShotIdx = keywordServerData[indexPath.row].styleshotIdx
        self.navigationController?.pushViewController(styleDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 616
    }
}


extension KeywordVC{
    /*
    func didSuccessGetKeyword(message: String){
        let cnt :Int = keywordServerData.count
        entireHeight.constant = CGFloat(136 + (cnt * 616))
        //setCVTV()
        postTV.reloadData()
    }*/
}

extension KeywordVC : RecentTVCDelegate{
    func didTapLike(isLiked: Bool, styleShotIdx: Int, heartButton: UIButton, heartCnt: Int, heartNumLabel: UILabel) {
        if !isLiked{
            StyleDetailDataManager().likeStyle(styleShotIdx) { success in
                guard success else{
                    return
                }
                DispatchQueue.main.async {
                    heartButton.setImage(UIImage(named: "icHeartClick1"), for: .normal)
                    heartNumLabel.text = "\(heartCnt+1)"
                }
            }
        }else{
            let dislikeRequest = disLikeRequest(status: "N")
            StyleDetailDataManager().disLikeStyle(dislikeRequest, styleshotIdx: styleShotIdx) { success in
                guard success else{
                    return
                }
                DispatchQueue.main.async {
                    heartButton.setImage(UIImage(named: "icHeartUnclick1"), for: .normal)
                    heartNumLabel.text = "\(heartCnt-1)"
                }
            }
        }
    }
}
