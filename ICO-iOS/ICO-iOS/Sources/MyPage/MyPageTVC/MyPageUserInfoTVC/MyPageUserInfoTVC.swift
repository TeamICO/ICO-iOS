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
        
        self.userNameLabel.text = viewModel.userName
        self.secondUserNameLabel.text = viewModel.userName
        self.treeLabel.text = "나무를 지킬 수 있는 행동을 \(viewModel.tree)번 실천했어요."
        self.earthLabel.text = "지속가능한 지구를 위한 실천을 위해 \(viewModel.earth)번 노력하였어요."
        self.togetherLabel.text = "나와 환경 모두를 지킬 수 있는 행동을 \(viewModel.together)번째 지속하고 있어요."
        self.userIcoLevelImage.image = UIImage(named: icolevleImages[viewModel.userIcoLevel-1])
        guard let image = viewModel.userImage else{
            return
        }
        if image == ""{
            self.userImage.image = UIImage(named: "img_profile_default")
        }else{
            self.userImage.setImage(with: image)
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
        self.userName = model.nickname
        self.tree = model.tree
        self.earth = model.earth
        self.together = model.together
        
    }
}
 
