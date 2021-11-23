//
//  emptyStyleShotCVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/23.
//

import UIKit

class emptyStyleShotCVC: UICollectionViewCell {
    
    @IBOutlet weak var emptyLabel1: UILabel!
    @IBOutlet weak var emptyLabel2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setStyle()
    }
    
    func setStyle(){
        emptyLabel1.textColor = UIColor.primaryBlack80
        emptyLabel2.textColor = UIColor.primaryBlack60
    }

}
