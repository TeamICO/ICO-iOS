//
//  NoneSearchResultCVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/27.
//

import UIKit

class NoneSearchResultCVC: UICollectionViewCell {
    static let identifier = "NoneSearchResultCVC"
    
    @IBOutlet weak var subtitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        subtitleLabel.text = "검색하고자 하는 키워드의 띄어쓰기,\n맞춤법 등을 확인해보세요."
    }

}
