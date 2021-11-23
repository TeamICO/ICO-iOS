//
//  KeywordContentsTopTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/23.
//

import UIKit

class KeywordContentsTopTVC: UITableViewCell {
    static let identifier = "KeywordContentsTopTVC"
    
    
    
    @IBOutlet weak var titleIconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentLabel2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    
    func configure(index : Int){
        let model = KeywordContentsModel()
        self.titleIconImage.image = UIImage(named: model.titleIconImage[index])
        self.titleLabel.text = model.title[index]
        self.titleImage.image = UIImage(named:model.titleImage[index])
        self.contentLabel.text = model.content[index]
        self.contentLabel2.text = model.content2[index]
    }
    
    
}
