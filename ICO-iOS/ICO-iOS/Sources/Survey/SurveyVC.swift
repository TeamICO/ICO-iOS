//
//  SurveyVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/10.
//

import UIKit

class SurveyVC: UIViewController {
    
    var name: String = "경서"
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet var titleLabel: [UILabel]!
    @IBOutlet var emojiLabel: [UILabel]!
    
    @IBOutlet var emojiView: [UIView]!
    
    @IBOutlet var uploadBtn: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()

       setUI()
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    

    @IBAction func toBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUI(){
        mainLabel.text = "\(name)님의 관심 키워드를\n선택해주세요."
        mainLabel.font = UIFont.init(name: "AppleSDGothicNeo-Light", size: 24)
        /*
        let attributedStr = NSMutableAttributedString(string: mainLabel.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        attributedStr.addAttribute(.font, value: UIFont.init(name: "AppleSDGothicNeo-SemiBol", size: 24), range: (mainLabel.text! as NSString).range(of: "\(name)"))
       // attributedStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMaxRange(0, attributedStr.length))
        mainLabel.attributedText = attributedStr*/
        
        
        for i in 0...3{
            titleLabel[i].font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 16)
        }
        
        for j in 0...13{
            emojiLabel[j].font = UIFont.init(name: "AppleSDGothicNeo-Medium", size: 14)
            emojiLabel[j].textColor = UIColor.primaryBlack60
            emojiView[j].cornerRadius = 16
            emojiView[j].backgroundColor = UIColor.lightShadow
        }
        
        for i in 0...1{
            uploadBtn[i].clipsToBounds = true
            uploadBtn[i].cornerRadius = 12
            uploadBtn[i].titleLabel?.font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 20)
        }
        
        uploadBtn[0].setTitleColor(UIColor.black, for: .normal)
        uploadBtn[1].setTitleColor(UIColor.white, for: .normal)
        uploadBtn[1].setTitle("완료!", for: .normal)
        
        uploadBtn[1].setGradient(color1: UIColor.gradient01, color2: UIColor.gradient012)
        uploadBtn[0].backgroundColor = UIColor.white
        uploadBtn[0].borderWidth = 1
        uploadBtn[0].borderColor = UIColor.coGreen70
    }
    
    
    @IBAction func toHome(_ sender: Any) {
        let vc = BaseTBC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    

}
