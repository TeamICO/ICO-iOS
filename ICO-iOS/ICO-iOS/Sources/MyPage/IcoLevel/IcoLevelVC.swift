//
//  IcoLevelVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

class IcoLevelVC: UIViewController {

    
    private let levelLabels = [
                    "Lev.1 새싹 아이코",
                    "Lev.2 새싹 아이코",
                    "Lev.3 새싹 아이코",
                    "Lev.4 새싹 아이코",
                    "Lev.5 새싹 아이코"
    ]
    private let levelDescriptions = [
                    "열정가득한 새싹 아이코, 환경을 위해 첫 걸음을 딛어봐요!",
                    "실천 의지가 돋보이는 아이코! 당신의 노력이 세상을 바꿀 거예요.",
                    "연륜이 있는 아이코! 아이코의 열정 가득한 실천에 감동했어요.",
                    "정말 많은 노력을 보여준 아이코!\n당신의 실천에 박수를 보냅니다.",
                    "소중한 베스트 아이코! 아이코의 가치있는 행동들이 많은 것을 바꿨어요."
    ]
    private let levelIcons = [
                    "illust-ico01",
                    "illust-ico02",
                    "illust-ico03",
                    "illust-ico04",
                    "illust-ico05"
    ]

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewConfigure()
        
    }
    

    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
// MARK: - TableView Configure
extension IcoLevelVC {
    func tableviewConfigure(){
        let IcoLevelTopTVCNib = UINib(nibName: IcoLevelTopTVC.identifier, bundle: nil)
        tableView.register(IcoLevelTopTVCNib, forCellReuseIdentifier: IcoLevelTopTVC.identifier)

        let IcoLevelTVCNib = UINib(nibName: IcoLevelTVC.identifier, bundle: nil)
        tableView.register(IcoLevelTVCNib, forCellReuseIdentifier: IcoLevelTVC.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = nil
        tableView.tableFooterView = nil
        tableView.sectionFooterHeight = 0
        tableView.sectionHeaderHeight = 0
        tableView.separatorStyle = .none

    }
}
// MARK: - TableView Delegate, DataSource
extension IcoLevelVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return 1
        case 1 :
            return levelLabels.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: IcoLevelTopTVC.identifier, for: indexPath) as! IcoLevelTopTVC
            cell.selectionStyle = .none
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: IcoLevelTVC.identifier, for: indexPath) as! IcoLevelTVC
            cell.levelDes.text = levelDescriptions[indexPath.row]
            cell.levelLabel.text = levelLabels[indexPath.row]
            cell.icoLevelImage.image = UIImage(named: levelIcons[indexPath.row])
            cell.selectionStyle = .none
            return cell

        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0 :
            return 190 // 타이틀 탑 패딩 12+ 서브타이틀 바텀 패딩 16+ 상단 네비게이션 높이 54
        case 1 :
            return 100
        default:
            return UITableView.automaticDimension
        }
        
    }
}
