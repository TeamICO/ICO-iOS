//
//  KeywordContentsTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/23.
//

import UIKit

class KeywordContentsTVC: UITableViewCell {
    static let identifier = "KeywordContentsTVC"
    
    
    @IBOutlet weak var brandTitleLabel: UILabel!
    @IBOutlet weak var brandImage: UIImageView!
    @IBOutlet weak var brandDesLabel: UILabel!
    @IBOutlet weak var brandDesLabel2: UILabel!
    @IBOutlet weak var brandDesLabel3: UILabel!
    @IBOutlet weak var brandCheckLabel: UILabel!
    @IBOutlet weak var brandCheckLabel2: UILabel!
    @IBOutlet weak var brandCheckLabel3: UILabel!
    @IBOutlet weak var brandCheckView: UIView!
    @IBOutlet weak var brandCheckViewTop: NSLayoutConstraint!
    @IBOutlet weak var brandCheckViewHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(index : Int,cellIndex : Int){
        
        switch cellIndex {
        case 0:
            let model = ContentsBrand1()
            self.brandTitleLabel.text = model.brandTitle[index]
            self.brandImage.image = UIImage(named: model.brandImage[index])
            self.brandDesLabel.text = model.brandDes[index]
            self.brandDesLabel2.text = model.brandDes2[index]
      
            if !model.brandCheck.isEmpty{
                self.brandCheckLabel.text = model.brandCheck[index]
                self.brandCheckLabel2.text = model.brandCheck2[index]
                self.brandCheckLabel3.text = model.brandCheck3[index]
                
            }else{
                brandCheckViewHeight.constant = 0
                
            }
            self.brandDesLabel3.text = model.brandDes3[index]
            break
        case 1:
            let model = ContentsBrand2()
            self.brandTitleLabel.text = model.brandTitle[index]
            self.brandImage.image = UIImage(named: model.brandImage[index])
            self.brandDesLabel.text = model.brandDes[index]
            self.brandDesLabel2.text = model.brandDes2[index]
      
            if !model.brandCheck.isEmpty{
                self.brandCheckLabel.text = model.brandCheck[index]
                self.brandCheckLabel2.text = model.brandCheck2[index]
                self.brandCheckLabel3.text = model.brandCheck3[index]
                
            }else{
                brandCheckViewHeight.constant = 0
                brandCheckViewTop.constant = 0
                brandCheckView.isHidden = true
                
            }
            self.brandDesLabel3.text = model.brandDes3[index]
            break
        case 2:
            let model = ContentsBrand3()
            self.brandTitleLabel.text = model.brandTitle[index]
            self.brandImage.image = UIImage(named: model.brandImage[index])
            self.brandDesLabel.text = model.brandDes[index]
            self.brandDesLabel2.text = model.brandDes2[index]
      
            if !model.brandCheck.isEmpty{
                self.brandCheckLabel.text = model.brandCheck[index]
                self.brandCheckLabel2.text = model.brandCheck2[index]
                self.brandCheckLabel3.text = model.brandCheck3[index]
                
            }else{
                brandCheckViewHeight.constant = 0
                brandCheckViewTop.constant = 0
                brandCheckView.isHidden = true
            }
            self.brandDesLabel3.text = model.brandDes3[index]
            break
        default : break
        }
         
        
    }

}

