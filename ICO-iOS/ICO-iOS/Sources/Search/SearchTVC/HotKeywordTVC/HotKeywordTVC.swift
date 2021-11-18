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
    
    private var leftHotKeywords = ["비건","업사이클링 기구","유기농 간편식","클린뷰티","대나무 칫솔"]
    private var rightHotKeywords = ["친환경 마스크","프라이탁","멜릭서","유기농 간편식","업사이클링 패션"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        
        for i in 1...5{
            let stack = HokeywordSV()
            stack.rankLabel.text = "\(i)"
            stack.rankTitleLabel.text = leftHotKeywords[i-1]
            leftStackView.addArrangedSubview(stack)
            
        }
        for i in 1...5{
            let stack = HokeywordSV()
            stack.rankLabel.text = "\(i+5)"
            stack.rankTitleLabel.text = rightHotKeywords[i-1]
            rightStackView.addArrangedSubview(stack)
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
