//
//  PopularVC.swift
//  ICO
//
//  Created by 이은영 on 2021/11/03.
//

import UIKit

class PopularVC: UIViewController {
    
    @IBOutlet weak var stackView: UIView!
    @IBOutlet weak var stackView2: UIView!
    @IBOutlet weak var popularLabel: UILabel!
    
    @IBOutlet weak var postTV: UITableView!
    @IBOutlet weak var popularIcoCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        registerXib()
        setTVCV()
        // Do any additional setup after loading the view.
    }
    
    func registerXib(){
        postTV.register(UINib(nibName: "RecentTVC", bundle: nil), forCellReuseIdentifier: "RecentTVC")
        popularIcoCV.register(UINib(nibName: "PopularIcoCVC", bundle: nil), forCellWithReuseIdentifier: "PopularIcoCVC")
    }
    
    func setTVCV(){
        postTV.delegate = self
        postTV.dataSource = self
        popularIcoCV.delegate = self
        popularIcoCV.dataSource = self
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentTVC", for: indexPath)as? RecentTVC else {return UITableViewCell()}
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 616
    }

}

extension PopularVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularIcoCVC", for: indexPath)as? PopularIcoCVC else {return UICollectionViewCell()}
        
        return cell
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
