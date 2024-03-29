//
//  ProfileUserIntroductionTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/11.
//

import UIKit

protocol ProfileUserIntroductionTVCDelegate : AnyObject{
    func getTextViewText(text: String)
}
 
class ProfileUserIntroductionTVC: UITableViewCell {
    static let identifier = "ProfileUserIntroductionTVC"
    weak var delegate :  ProfileUserIntroductionTVCDelegate?
    
    @IBOutlet weak var profileTextView: UITextView!
    @IBOutlet weak var profileTextCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        profileTextView.delegate = self
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        profileTextView.text = nil
    }
    func configure(with viewModel : ProfileUserInfoTVCViewModel){
        
        self.profileTextView.text =  viewModel.description
        if let text = viewModel.description{
            
            self.profileTextCountLabel.text = "\(text.count)"
       
        }
       
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func didTapRemoveNicNameButton(_ sender: Any) {
        profileTextView.text = ""
        
        profileTextView.tintColor = UIColor.appColor(.feedbackTintColor)
    }
}
// MARK: - TextView Delegate
extension ProfileUserIntroductionTVC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if !textView.text.isEmpty{
            if textView.text == "프로필 소개 글을 입력해주세요."{
                textView.text = ""
            }
            textView.tintColor = UIColor.appColor(.feedbackTintColor)
            textView.textColor = UIColor.appColor(.feedbackinpuTextColor)
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
         if textView.text.isEmpty {
             textView.text = "프로필 소개 글을 입력해주세요."
             textView.textColor = UIColor.appColor(.feedbackTextColor)
         }
     }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if profileTextView.text.count > 52 {
            profileTextView.deleteBackward()
        }
        profileTextCountLabel.text = "\(profileTextView.text.count)"
        guard let text = profileTextView.text, text.isExists else{
            return true
        }
        delegate?.getTextViewText(text: text)
        return true
    }
}
