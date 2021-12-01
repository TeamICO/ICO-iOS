//
//  RecentVC.swift
//  ICO
//
//  Created by 이은영 on 2021/11/03.
//

import UIKit

class RecentVC: BaseViewController {
    
    var isStart = false
    
    var serverData : [RecentResult] = []
    var styleshotIdx: Int = 0
    @IBOutlet weak var postingTV: UITableView!
   /*
    override func viewWillAppear(_ animated: Bool) {
        StyleLifeDataManager().getRecentInfo(self)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 68))
        postingTV.tableHeaderView = header
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
        postingTV.tableFooterView = footer
       // StyleLifeDataManager().getRecentInfo(pagination: false, lastIndex: 0, self)
        fetchData()
        registerXib()
    }

    func registerXib(){
        postingTV.register(UINib(nibName: "RecentTVC", bundle: nil), forCellReuseIdentifier: "RecentTVC")
    }
    
    func setTV(){
        postingTV.delegate = self
        postingTV.dataSource = self
    }
}


extension RecentVC{
    func fetchData(){
        StyleLifeDataManager.shared.getRecentInfo(pagination: false, lastIndex: 0, self){[weak self] response in
            guard let response = response else {
                return
            }
            self?.serverData = response
            self?.postingTV.reloadData()
            self?.setTV()
            if response.isEmpty{
                self?.postingTV.isScrollEnabled = false
            }
            self?.isStart = true
        }

      
    }
}


extension RecentVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serverData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentTVC", for: indexPath)as? RecentTVC else {return UITableViewCell()}
        
        cell.selectionStyle = .none
        
        cell.mainImage.setImage(with: serverData[indexPath.row].imageURL)
        cell.userImage.setImage(with: serverData[indexPath.row].profileURL)
        cell.productName.text = serverData[indexPath.row].productName
        cell.nameLabel.text = "\(serverData[indexPath.row].nickname)"
        var score1  = serverData[indexPath.row].point
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
        cell.heartCnt = serverData[indexPath.row].likeCnt
        cell.heartNum.text = "\(serverData[indexPath.row].likeCnt)"
        cell.styleShotIdx = serverData[indexPath.row].styleshotIdx
        if serverData[indexPath.row].isLike == 0{
            cell.heartBtn.setImage(UIImage(named: "icHeartUnclick1"), for: .normal)
            cell.isliked = false
        }else{
            cell.heartBtn.setImage(UIImage(named: "icHeartClick1"), for: .normal)
            cell.isliked = true
        }
        cell.detailLabel.text = serverData[indexPath.row].resultDescription
        cell.time.text = serverData[indexPath.row].time
        cell.setData(category: serverData[indexPath.row].category)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let styleDetailSB = UIStoryboard(name: "StyleDetail", bundle: nil)
        let styleDetailVC = styleDetailSB.instantiateViewController(withIdentifier: "StyleDetailVC")as! StyleDetailVC
        styleDetailVC.isMine = false
        styleDetailVC.styleShotIdx = serverData[indexPath.row].styleshotIdx
        self.navigationController?.pushViewController(styleDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 630
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffY = scrollView.contentOffset.y
        
        if contentOffY >= (postingTV.contentSize.height+150-scrollView.frame.size.height){
         
            guard isStart != nil else{
                return
            }
            
            guard !StyleLifeDataManager.shared.isRecentPaginating else{
                return
            }
            
            StyleLifeDataManager.shared.getRecentInfo(pagination: true, lastIndex: self.serverData.count, self){ [weak self] response in
                guard let response = response else{
                    return
                }
                self?.serverData.append(contentsOf: response)
                self?.postingTV.reloadData()
            }
            
        }
    }
    
}


extension RecentVC{
    func didSuccessGetRecentInfo(message: String){
        //setTV()
        postingTV.reloadData()
        self.isStart = true
    }
}

extension RecentVC : RecentTVCDelegate{
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
