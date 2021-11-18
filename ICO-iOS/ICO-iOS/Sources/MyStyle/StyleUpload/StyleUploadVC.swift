//
//  StyleUploadVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/10.
//

import UIKit

class StyleUploadVC: UIViewController {
    
    var photoNum : Int = 0
    var urlNum1: Int = 0
    var urlNum2: Int = 0
    
    @IBOutlet weak var navigationTitle: UILabel!
    @IBOutlet var levelTitle: [UILabel]!
    @IBOutlet var mainTitle: [UILabel]!
    @IBOutlet var urlTitle: [UILabel]!
    @IBOutlet var lineView: [UIView]!
    
    @IBOutlet var urlTextField: [UITextField]!
    
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var imgNumLabel: UILabel!
    
    @IBOutlet var keywordView: [UIView]!
    @IBOutlet var keywordName: [UILabel]!
    
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var imageNumView: UIView!
    
    @IBOutlet var essentialView: [UIView]!
    @IBOutlet var essentialLabel: [UILabel]!
    
    @IBOutlet weak var urlLabel1: UILabel!
    @IBOutlet weak var urlLabel2: UILabel!
    
    @IBOutlet weak var memoView: UIView!
    @IBOutlet weak var memoTextView: UITextView!
    
    
    @IBOutlet weak var uploadBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
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
        
        for i in 0...6{
            keywordView[i].cornerRadius = 8
            keywordName[i].font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
        }
        
        keywordView[0].backgroundColor = UIColor.lightWarning
        keywordName[0].textColor = UIColor.alertWarning
        keywordView[1].backgroundColor = UIColor.lightSuccess
        keywordName[1].textColor = UIColor.alertsSuccess
        keywordView[2].backgroundColor = UIColor.lightInfo
        keywordName[2].textColor = UIColor.alertsInfo
        keywordView[3].backgroundColor = UIColor.lightPoint
        keywordName[3].textColor = UIColor.point
        keywordView[4].backgroundColor = UIColor.primaryigreen5
        keywordName[4].textColor = UIColor.coGreen60
        
        keywordView[6].backgroundColor = UIColor.lightShadow
        keywordName[5].textColor = UIColor.primaryBlack80
        keywordView[5].backgroundColor = UIColor.lightError
        keywordName[6].textColor = UIColor.alertsError
        
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
        imgNumLabel.text = "\(photoNum)/1"
        imgNumLabel.textColor = UIColor.white
        imgNumLabel.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
    
        uploadBtn.setGradient(color1: UIColor.gradient01, color2: UIColor.gradient012)
        uploadBtn.setTitleColor(UIColor.white, for: .normal)
        uploadBtn.layer.cornerRadius = 12
        uploadBtn.clipsToBounds = true
        uploadBtn.titleLabel?.font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 20)
        
        memoView.backgroundColor = UIColor.white
        memoView.cornerRadius = 8
        memoView.borderWidth = 0.5
        memoView.borderColor = UIColor.primaryBlack50
        
        
        urlLabel1.text = "\(urlNum1)/20"
        urlLabel2.text = "\(urlNum2)/20"
    }
    

    @IBAction func toBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func uploadBtn(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    
}

extension StyleUploadVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            newImageView.contentMode = .scaleAspectFill
            newImageView.image = pickedImage
            photoNum = 1
            imgNumLabel.text = "\(photoNum)/1"
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
