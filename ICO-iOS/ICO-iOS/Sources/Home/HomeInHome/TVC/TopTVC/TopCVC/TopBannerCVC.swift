//
//  TopBannerCVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/05.
//

import UIKit

class TopBannerCVC: UICollectionViewCell {
    static let identifier = "TopBannerCVC"
    
    @IBOutlet weak var bannerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        bannerImage.image = nil
    }
 
}
