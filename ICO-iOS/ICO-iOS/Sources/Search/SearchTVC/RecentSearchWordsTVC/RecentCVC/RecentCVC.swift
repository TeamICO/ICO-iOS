//
//  RecentCVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/09.
//

import UIKit
protocol RecentCVCDelegate : AnyObject{
    func didTapDeleteWordButton(keywordIdx : Int)
}

class RecentCVC: UICollectionViewCell {
    static let identifier = "RecentCVC"
    
    weak var delegate : RecentCVCDelegate?
    var keywordIdx = 0
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.coGreen5
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }

    @IBAction func didTapDeleteButton(_ sender: Any) {
        delegate?.didTapDeleteWordButton(keywordIdx: self.keywordIdx)
    }
}
