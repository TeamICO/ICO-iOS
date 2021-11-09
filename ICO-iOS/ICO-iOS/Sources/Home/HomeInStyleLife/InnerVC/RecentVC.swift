//
//  RecentVC.swift
//  ICO
//
//  Created by 이은영 on 2021/11/03.
//

import UIKit

class RecentVC: UIViewController {
    
    @IBOutlet weak var postingTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerXib()
        setTV()
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

