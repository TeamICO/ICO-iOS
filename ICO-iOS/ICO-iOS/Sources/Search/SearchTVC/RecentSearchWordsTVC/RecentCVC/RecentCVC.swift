//
//  RecentCVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/09.
//

import UIKit
protocol RecentCVCDelegate : AnyObject{
    func didTapDeleteWordButton(keywordIdx : Int)
    func didtapKeywordView(keyword : String)
}

class RecentCVC: UICollectionViewCell {
    static let identifier = "RecentCVC"
    
    weak var delegate : RecentCVCDelegate?
    var keywordIdx = 0
    
    @IBOutlet weak var wordlabelWidth: NSLayoutConstraint!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.backgroundColor = UIColor.coGreen5
        cellView.layer.cornerRadius = 8
        cellView.layer.masksToBounds = true
        setTapGesture()
    }

    override func prepareForReuse() {
        self.wordLabel.text = nil
        
    }
    
    func configure(with model : KeywordHistory){
        self.wordLabel.text = model.keyword
    }
    
    func setTapGesture() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(didtapView))
//        tap.cancelsTouchesInView = false
        self.cellView.addGestureRecognizer(tap)
    }
    
    @objc func didtapView() {
        guard let keyword = wordLabel.text else{
            return
        }
        delegate?.didtapKeywordView(keyword: keyword)
    }


    @IBAction func didTapDeleteButton(_ sender: Any) {
        delegate?.didTapDeleteWordButton(keywordIdx: self.keywordIdx)
    }
}

