//
//  SearchKeywordTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/25.
//

import UIKit

protocol SearchKeywordTVCDelegate : AnyObject{
    func didTapSearchResultView(resultkeyword : String)
}

class SearchKeywordTVC: UITableViewCell {
    static let identifier = "SearchKeywordTVC"
    
    weak var delegate : SearchKeywordTVCDelegate?
    
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var searchResultView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setViewTapGesture()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    func configure(keyword : String){
        let attributedStr = NSMutableAttributedString(string: keywordLabel.text!)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.coGreen70, range: (keywordLabel.text! as NSString).range(of: keyword))
        keywordLabel.attributedText = attributedStr
        
        
    }
    
    func setViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapResultView))
        viewTap.cancelsTouchesInView = false
        searchResultView.addGestureRecognizer(viewTap)
    }
    @objc func didTapResultView(){
        guard let keyword = keywordLabel.text, keyword.isExists else{
            return
        }
        delegate?.didTapSearchResultView(resultkeyword: keyword)
    }
    
}
