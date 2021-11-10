//
//  IcoLevelTopTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

class IcoLevelTopTVC: UITableViewCell {
    static let identifier = "IcoLevelTopTVC"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = "아이코의 에코레벨에 대해\n알려드릴게요"
        subTitleLabel.text = "업로드한 스타일샷을 통해 환경에 끼친\n영향을 파악하여 레벨을 측정합니다."
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
