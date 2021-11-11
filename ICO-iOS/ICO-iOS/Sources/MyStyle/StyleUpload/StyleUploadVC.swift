//
//  StyleUploadVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/10.
//

import UIKit

class StyleUploadVC: UIViewController {
    
    var photoNum : Int = 0
    
    @IBOutlet weak var navigationTitle: UILabel!
    @IBOutlet var levelTitle: [UILabel]!
    @IBOutlet var mainTitle: [UILabel]!
    @IBOutlet var urlTitle: [UILabel]!
    @IBOutlet var lineView: [UIView]!
    
    @IBOutlet var urlTextField: [UITextField]!
    
    @IBOutlet weak var imageView: UIView!
    
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var imageNumView: UIView!
    
    @IBOutlet var essentialView: [UIView]!
    @IBOutlet var essentialLabel: [UILabel]!
    
    
    @IBOutlet weak var memoView: UIView!
    @IBOutlet weak var memoTextView: UITextView!
    
    
    @IBOutlet weak var uploadBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        // Do any additional setup after loading the view.
    }
    
    func setUI(){
        navigationTitle.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 20)
        for i in 0...5{
            levelTitle[i].font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 16)
        }
        for i in 0...5{
            mainTitle[i].font = UIFont.init(name: "AppleSDGothicNeo-Light", size: 16)
        }
        for i in 0...4{
            lineView[i].backgroundColor = UIColor.backGround1
        }
        
        for i in 0...1{
            urlTitle[i].font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 16)
            urlTitle[i].textColor = UIColor.primaryBlack60
            urlTextField[i].backgroundColor = UIColor.backGround1
            urlTextField[i].cornerRadius = 8
        }
        
        for i in 0...3{
            essentialView[i].cornerRadius = 8
            essentialView[i].backgroundColor = UIColor.backGround1
            essentialLabel[i].textColor = UIColor.alertsError
            essentialLabel[i].font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
        }
        
        imageView.backgroundColor = UIColor.primaryBlack10
        imageView.cornerRadius = 16
        newImageView.cornerRadius = 16
        imageNumView.backgroundColor = UIColor.primaryBlack40
        imageNumView.cornerRadius = 8
        
        let font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 16)
        let attributedStr1 = NSMutableAttributedString(string: mainTitle[0].text!)
        attributedStr1.addAttribute(.font, value: font, range: (mainTitle[0].text as! NSString).range(of: "스타일샷"))
        mainTitle[0].attributedText = attributedStr1
        
        let attributedStr2 = NSMutableAttributedString(string: mainTitle[1].text!)
        attributedStr2.addAttribute(.font, value: font, range:(mainTitle[1].text! as NSString).range(of: "에코 키워드"))
        mainTitle[1].attributedText = attributedStr2
        
        let attributedStr3 = NSMutableAttributedString(string: mainTitle[2].text!)
        attributedStr3.addAttribute(.font, value: font, range:(mainTitle[2].text! as NSString).range(of: "만족도"))
        mainTitle[2].attributedText = attributedStr3
        
        let attributedStr4 = NSMutableAttributedString(string: mainTitle[3].text!)
        attributedStr4.addAttribute(.font, value: font, range:(mainTitle[3].text! as NSString).range(of:
        "제품 URL"))
        mainTitle[3].attributedText = attributedStr4
        
        let attributedStr5 = NSMutableAttributedString(string: mainTitle[4].text!)
        attributedStr5.addAttribute(.font, value: font, range:(mainTitle[4].text! as NSString).range(of:
        "상세내용"))
        mainTitle[4].attributedText = attributedStr5
        
        let attributedStr6 = NSMutableAttributedString(string: mainTitle[5].text!)
        attributedStr6.addAttribute(.font, value: font, range:(mainTitle[5].text! as NSString).range(of:
        "어울리는 해시태그"))
        mainTitle[5].attributedText = attributedStr6
        

        plusBtn.setImage(UIImage(named: "icPlus1"), for: .normal)
    
        uploadBtn.setGradient(color1: UIColor.gradient01, color2: UIColor.gradient012)
        uploadBtn.setTitleColor(UIColor.white, for: .normal)
        uploadBtn.layer.cornerRadius = 12
        uploadBtn.clipsToBounds = true
        uploadBtn.titleLabel?.font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 20)
        
        memoView.backgroundColor = UIColor.white
        memoView.cornerRadius = 8
        memoView.borderWidth = 0.5
        memoView.borderColor = UIColor.primaryBlack50
    }
    

    @IBAction func toBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
