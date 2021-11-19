//
//  MyPageUserInfoTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

protocol MyPageUserInfoTVCDelegate : AnyObject{
    func didTapIcoButton()
}

class MyPageUserInfoTVC: UITableViewCell {
    static let identifier = "MyPageUserInfoTVC"
    
    private let icolevleImages = [
        "illust-ico01",
        "illust-ico02",
        "illust-ico03",
        "illust-ico04",
        "illust-ico05"
    ]
    
    weak var delegate : MyPageUserInfoTVCDelegate?
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userIcoLevelImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var secondUserNameLabel: UILabel!
    
    @IBOutlet weak var treeLabel: UILabel!
    @IBOutlet weak var earthLabel: UILabel!
    @IBOutlet weak var togetherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    func configure(with viewModel: MyPageUserInfoTVCViewModel){ 
        
        
        self.treeLabel.text = "나무를 지킬 수 있는 행동을 \(viewModel.tree)번 실천했어요."
        self.earthLabel.text = "지속가능한 지구를 위한 실천을 위해 \(viewModel.earth)번 노력하였어요."
        self.togetherLabel.text = "나와 환경 모두를 지킬 수 있는 행동을 \(viewModel.together)번째 지속하고 있어요."
        self.userIcoLevelImage.image = UIImage(named: icolevleImages[viewModel.userIcoLevel-1])
        
        guard let userimage = viewModel.userImage,let userName = viewModel.userName, let url = URL(string: userimage) else{
            return
        }
        self.userNameLabel.text = userName
        var name = userName
        name.removeFirst()
        self.secondUserNameLabel.text = name
        DispatchQueue.global().async {
                let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                    guard let data = data else{
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self?.userImage.image = UIImage(data: data)
                    }
                }
                task.resume()
        }
        
    }
    
    
    @IBAction func didTapIcoButton(_ sender: Any) {
        delegate?.didTapIcoButton()
    }
    
}
struct MyPageUserInfoTVCViewModel {
    let userIcoLevel : Int
    let userImage : String?
    let userName : String?
    let tree : Int
    let earth : Int
    let together : Int
    
    
    
    init(with model : MypageResult){
        self.userIcoLevel = model.level
        self.userImage = model.profileURL
        self.userName = model.name
        self.tree = model.tree
        self.earth = model.earth
        self.together = model.together
        
    }
}
 
