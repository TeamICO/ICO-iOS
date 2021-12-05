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
    @IBOutlet weak var brandDesLabel1: UILabel!
    @IBOutlet weak var brandDesLabel2: UILabel!
    @IBOutlet weak var brandDesLabel3: UILabel!
    @IBOutlet weak var brandCheckLabel1: UILabel!
    @IBOutlet weak var brandCheckLabel2: UILabel!
    @IBOutlet weak var brandCheckLabel3: UILabel!
    @IBOutlet weak var brandCheckView: UIView!
    @IBOutlet weak var brandCheckViewTop: NSLayoutConstraint!
    @IBOutlet weak var brandCheckViewHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLabelSpacing(label: brandDesLabel1)
        setLabelSpacing(label: brandDesLabel2)
        setLabelSpacing(label: brandDesLabel3)
        setLabelSpacing(label: brandCheckLabel1)
        setLabelSpacing(label: brandCheckLabel2)
        setLabelSpacing(label: brandCheckLabel3)
        
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
            self.brandDesLabel1.text = model.brandDes[index]
            self.brandDesLabel2.text = model.brandDes2[index]
      
            if !model.brandCheck.isEmpty{
                self.brandCheckLabel1.text = model.brandCheck[index]
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
            self.brandDesLabel1.text = model.brandDes[index]
            self.brandDesLabel2.text = model.brandDes2[index]
      
            if !model.brandCheck.isEmpty{
                self.brandCheckLabel1.text = model.brandCheck[index]
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
            self.brandDesLabel1.text = model.brandDes[index]
            self.brandDesLabel2.text = model.brandDes2[index]
      
            if !model.brandCheck.isEmpty{
                self.brandCheckLabel1.text = model.brandCheck[index]
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
    func setLabelSpacing(label : UILabel){
        let attrString = NSMutableAttributedString(string: label.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        label.attributedText = attrString
    }

}

