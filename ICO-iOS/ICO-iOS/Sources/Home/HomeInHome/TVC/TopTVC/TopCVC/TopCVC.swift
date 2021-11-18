//
//  TopCVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/07.
//

import UIKit

class TopCVC: UICollectionViewCell {
    static let identifier = "TopCVC"
    @IBOutlet weak var ecoIcon: UIImageView!
    
    @IBOutlet weak var ecoLabel: UILabel!
    @IBOutlet weak var ecoSubLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with viewModel : TopCVCViewModel){
        self.ecoIcon.image = UIImage(named: viewModel.iconImage)
        self.ecoLabel.text = viewModel.ecoTitle
        self.ecoSubLabel.text = viewModel.ecoSubTitle
    }

}
struct TopCVCViewModel{
    let iconImage : String
    let ecoTitle : String
    let ecoSubTitle : String
    init(iconImage : String, ecoTitle: String, ecoSubTitle: String){
        self.iconImage = iconImage
        self.ecoTitle = ecoTitle
        self.ecoSubTitle = ecoSubTitle
    }
}
