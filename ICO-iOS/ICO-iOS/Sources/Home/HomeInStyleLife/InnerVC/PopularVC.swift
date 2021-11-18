//
//  PopularVC.swift
//  ICO
//
//  Created by 이은영 on 2021/11/03.
//

import UIKit
import Kingfisher

class PopularVC: UIViewController {
    
    var serverData : Result?
    var popularServerData : [RecentResult] = []
    @IBOutlet weak var stackView: UIView!
    @IBOutlet weak var stackView2: UIView!
    @IBOutlet weak var popularLabel: UILabel!
    @IBOutlet weak var postTV: UITableView!
    @IBOutlet weak var popularIcoCV: UICollectionView!
    @IBOutlet weak var topBanner: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        StyleLifeDataManager().getStyleLifeTop(self)
        StyleLifeDataManager().getPopularInfo(self)
        setUI()
        registerXib()
        //setTVCV()
        // Do any additional setup after loading the view.
    }
    
    func registerXib(){
        postTV.register(UINib(nibName: "RecentTVC", bundle: nil), forCellReuseIdentifier: "RecentTVC")
        popularIcoCV.register(UINib(nibName: "PopularIcoCVC", bundle: nil), forCellWithReuseIdentifier: "PopularIcoCVC")
    }
    
    func setTVCV(){
        postTV.delegate = self
        postTV.dataSource = self
        //popularIcoCV.delegate = self
        //popularIcoCV.dataSource = self
    }
    
    
    
    func setUI(){
        stackView.backgroundColor = UIColor.backGround1
        stackView2.backgroundColor = UIColor.backGround1
        
        popularLabel.text = "지금 인기있는 아이코"
        popularLabel.font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 20)
    }

}

extension PopularVC: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularServerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentTVC", for: indexPath)as? RecentTVC else {return UITableViewCell()}
        
        cell.selectionStyle = .none
        cell.mainImage.setImage(with: popularServerData[indexPath.row].imageURL)
        cell.userImage.download(url: popularServerData[indexPath.row].profileURL, rounded: true)
        cell.nameLabel.text = "\(popularServerData[indexPath.row].nickname)"
        cell.productName.text = popularServerData[indexPath.row].productName
        cell.detailLabel.text = popularServerData[indexPath.row].resultDescription
        cell.heartNum.text = "\(popularServerData[indexPath.row].likeCnt)"
        cell.time.text = popularServerData[indexPath.row].time
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 616
    }

}

extension PopularVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serverData?.popularIco.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularIcoCVC", for: indexPath)as? PopularIcoCVC else {return UICollectionViewCell()}
        
        cell.icoName.text = serverData?.popularIco[indexPath.row].nickname
        cell.icoImage.download(url: serverData?.popularIco[indexPath.row].profileURL ?? "", rounded: true)
        if serverData?.popularIco[indexPath.row].latestCategory == "업사이클링"{
            cell.iconImage.image = UIImage(named: "illust-styleshot-upcycling")
        }else if serverData?.popularIco[indexPath.row].latestCategory == "비건"{
            cell.iconImage.image = UIImage(named: "illust-product-vegan")
        }else if serverData?.popularIco[indexPath.row].latestCategory == "제로웨이스트"{
            cell.iconImage.image = UIImage(named: "illust-product-package")
        }else if serverData?.popularIco[indexPath.row].latestCategory == "가치"{
            cell.iconImage.image = UIImage(named: "illust-styleshot-value")
        }else if serverData?.popularIco[indexPath.row].latestCategory == "유기농"{
            cell.iconImage.image = UIImage(named: "illust-styleshot-organic")
        }else if serverData?.popularIco[indexPath.row].latestCategory == "클린뷰티"{
            cell.iconImage.image = UIImage(named: "illust-styleshot-cleanbeauty")
        }else if serverData?.popularIco[indexPath.row].latestCategory == "에너지 절약"{
            cell.iconImage.image = UIImage(named: "illust-styleshot-energy")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let popularIcoSB = UIStoryboard(name: "PopularIco", bundle: nil)
        
        guard let popularIcoVC = popularIcoSB.instantiateViewController(withIdentifier: "PopularIco") as? PopularIcoVC else {return}
        popularIcoVC.id = serverData?.popularIco[indexPath.row].userIdx ?? 0
        
        self.navigationController?.pushViewController(popularIcoVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width
        
        let cellWidth = width * (96/375)
        let cellHeight = cellWidth * (125/96)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


extension PopularVC{
    func didSuccessGetTop(message: String){
        popularIcoCV.delegate = self
        popularIcoCV.dataSource = self
        popularIcoCV.reloadData()
        topBanner.setImage(with: serverData?.topBanner.imageURL ?? "")
        
        print(message)
    }
    
    func didSuccessGetPopularInfo(message: String){
        postTV.delegate = self
        postTV.dataSource = self
        postTV.reloadData()
        
        print(message)
    }
}
