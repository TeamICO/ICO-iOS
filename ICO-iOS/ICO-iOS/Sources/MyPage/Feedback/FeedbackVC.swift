//
//  FeedbackVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

class FeedbackVC: BaseViewController {
    // MARK: - Properties
    
    public var complition : ((Bool)->Void)?
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var FeedbackButton: UIButton!
    
    
    private let contentTextView : UITextView = {
        let view = UITextView(frame: CGRect(x: 0, y: 0, width: 0, height: 180))
        view.text = "시스템 오류, 서비스 피드백, 추가되면 좋을 것 같은 서비스 등 다양한 의견을 보낼 수 있어요."
        view.backgroundColor = UIColor.appColor(.feedbackBackgroundColor)
        view.isEditable = true
        view.tintColor = UIColor.appColor(.feedbackTintColor)
        view.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        view.textColor = UIColor.appColor(.feedbackTextColor)
        view.autocapitalizationType = .none
        view.autocorrectionType = .no
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let inputCountLabel : UILabel = {
        let label = UILabel()
        label.text = "53"
        label.textColor = UIColor.appColor(.feedbackinpuTextColor)
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let limitCountLabel : UILabel = {
        let label = UILabel()
        label.text = "/100"
        label.textColor = UIColor.appColor(.feedbackTextColor)
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardWhenTappedAround()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setBlurEffect(view: topView)
    }
    // MARK: - Configure
    func configure(){
        titleLabel.text = "아이코가 더 나은 서비스로 \n발전하기 위해 의견을 보내주세요."
        FeedbackButton.layer.cornerRadius = 12
        FeedbackButton.layer.masksToBounds = true
        if UIDevice.current.userInterfaceIdiom == .pad {
            FeedbackButton.backgroundColor = .gradient01
        }else{
            FeedbackButton.setGradient(color1: UIColor.appColor(.feedbackButtoncolor1), color2: UIColor.appColor(.feedbackButtoncolor2))
           
        }
        
        view.addSubview(contentTextView)
        contentTextView.delegate = self
        [contentTextView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16),
         contentTextView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -16),
         contentTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 24),
         contentTextView.widthAnchor.constraint(equalToConstant: view.frame.size.width-32),
         contentTextView.heightAnchor.constraint(equalToConstant: 111)].forEach{$0.isActive = true}
        

        view.addSubview(limitCountLabel)
        limitCountLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -16).isActive = true
        limitCountLabel.topAnchor.constraint(equalTo: contentTextView.bottomAnchor,constant: 2).isActive = true
        view.addSubview(inputCountLabel)
        inputCountLabel.rightAnchor.constraint(equalTo: limitCountLabel.leftAnchor).isActive = true
        inputCountLabel.topAnchor.constraint(equalTo: contentTextView.bottomAnchor,constant: 2).isActive = true
    }
    // MARK: - Selectors
    @IBAction func didTabpBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapHomeButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            self.complition?(true)
        }
    }
    
    @IBAction func didTapFeedbackButton(_ sender: Any) {
        guard let feedback = self.contentTextView.text, feedback.isExists, feedback == "", let jwtToken = self.jwtToken else{
            return
        }
        FeedbackManager.shared.sendFeedback(jwtToken : jwtToken,feedbackText: feedback) { success in
            guard success else{
                return
            }
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "CustomPopupSB", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "CustomPopupVC") as! CustomPopupVC
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                vc.text = "소중한 의견을 보내주셔서\n감사드립니다."
                self.present(vc, animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    vc.dismiss(animated: true) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
            
           
        }
    }
}
// MARK: - TextView Delegate
extension FeedbackVC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !textView.text.isEmpty{
            textView.text = ""
            textView.textColor = UIColor.appColor(.feedbackinpuTextColor)
            textView.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if contentTextView.text.count > 100 {
            contentTextView.deleteBackward()
        }
        inputCountLabel.text = "\(contentTextView.text.count)"
        return true
    }
    // 자동 높이 조절
    func textViewDidChange(_ textView: UITextView) {
        
       let estimatedSize = textView.sizeThatFits(CGSize(width: contentTextView.width, height: .infinity))
        
        textView.constraints.forEach{(constraint) in
            if constraint.firstAttribute == .height {
                if estimatedSize.height > 111 && estimatedSize.height < 340  {
                    constraint.constant = estimatedSize.height
                
                }
               
            }
        }
    }
}
