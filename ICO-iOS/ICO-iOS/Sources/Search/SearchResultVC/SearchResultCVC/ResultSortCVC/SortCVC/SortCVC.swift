//
//  SortCVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

protocol SortCVCDelagate : AnyObject{
    func didTapSort(sortedIdx : Int)
}

class SortCVC: UICollectionViewCell {
    static let identifier = "SortCVC"
    weak var delegate : SortCVCDelagate?
    
    var sortedIdx = 0
    
    
    @IBOutlet weak var sortView: UIView!
    @IBOutlet weak var sortTitleLabel: UILabel!
    @IBOutlet weak var sortIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override var isSelected: Bool{
        didSet{
            if isSelected{
                sortView.backgroundColor = UIColor.gradient012
                sortTitleLabel.textColor = .white
                sortTitleLabel.font = UIFont.init(name: "AppleSDGothicNeo-Semibold", size: 14)
                delegate?.didTapSort(sortedIdx: sortedIdx)
            }else{
                sortView.backgroundColor = UIColor.primaryBlack10
                sortTitleLabel.textColor = UIColor.primaryBlack80
                sortTitleLabel.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 14)
            }
        }
    }
    
}
