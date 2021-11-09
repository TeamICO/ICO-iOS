//
//  HotKeywordTVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/07.
//

import UIKit

class HotKeywordTVC: UITableViewCell {
    static let identifier = "HotKeywordTVC"
    @IBOutlet weak var leftStackView: UIStackView!
    @IBOutlet weak var rightStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        
        for i in 1...5{
            let stack = HotKeywordSV()
            stack.rankNumLabel.text = "\(i)"
            stack.rankTitleLabel.text = "비건 스킨"
            leftStackView.addArrangedSubview(stack)
            
        }
        for i in 1...5{
            let stack = HotKeywordSV()
            stack.rankNumLabel.text = "\(i+5)"
            stack.rankTitleLabel.text = "비건 스킨"
            rightStackView.addArrangedSubview(stack)
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
