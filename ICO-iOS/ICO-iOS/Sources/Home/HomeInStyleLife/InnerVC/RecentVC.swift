//
//  RecentVC.swift
//  ICO
//
//  Created by 이은영 on 2021/11/03.
//

import UIKit

class RecentVC: UIViewController {
    
    var serverData : [RecentResult] = []
    @IBOutlet weak var postingTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        StyleLifeDataManager().getRecentInfo(self)
        registerXib()
        //setTV()
    }

    func registerXib(){
        postingTV.register(UINib(nibName: "RecentTVC", bundle: nil), forCellReuseIdentifier: "RecentTVC")
    }
    
    func setTV(){
        postingTV.delegate = self
        postingTV.dataSource = self
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
        cell.score.text = "\(serverData[indexPath.row].point)"
        cell.heartNum.text = "\(serverData[indexPath.row].likeCnt)"
        cell.detailLabel.text = serverData[indexPath.row].resultDescription
        cell.time.text = serverData[indexPath.row].time
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 616
    }

    
}


extension RecentVC{
    func didSuccessGetRecentInfo(message: String){
        setTV()
        postingTV.reloadData()
        print(message)
    }
}
