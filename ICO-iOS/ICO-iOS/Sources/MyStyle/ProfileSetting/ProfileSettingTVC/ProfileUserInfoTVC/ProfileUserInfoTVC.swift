//
//  ProfileUserInfoTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/11.
//

import UIKit
protocol ProfileUserInfoTVCDelegate: AnyObject {
    func didTapUserImageView(image: UIImageView)
    func checkName(nickname: String,textField : UITextField,label: UILabel)
    func checkNicNameState(nickname : String)
}

class ProfileUserInfoTVC: UITableViewCell {
    static let identifier = "ProfileUserInfoTVC"
    
    weak var delegate : ProfileUserInfoTVCDelegate?
    
    @IBOutlet weak var userImageView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var nicknameStateLabel: UILabel!
    @IBOutlet weak var removeNicNameButton: UIButton!
    @IBOutlet weak var nicNameCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textfieldConfigure()
        setUserImageViewTapGesture()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImage.image = nil
        nickNameTextField.text = nil
    }
    func configure(with viewModel : ProfileUserInfoTVCViewModel){
        self.nickNameTextField.text = viewModel.nickName
        guard let image = viewModel.profileImage else{
            return
        }
        if image == ""{
            self.userImage.image = UIImage(named: "img_profile_default")
        }else{
            self.userImage.setImage(with: image)
        }

    }
    func textfieldConfigure(){
        nickNameTextField.leftViewMode = .always
        nickNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        nickNameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.appColor(.feedbackTextColor)])
        nickNameTextField.delegate = self
    }
    func setUserImageViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapUserImageView))
        viewTap.cancelsTouchesInView = false
        userImageView.addGestureRecognizer(viewTap)
    }
    @objc func didTapUserImageView(){
        delegate?.didTapUserImageView(image : self.userImage)
    }

    @IBAction func didTapRemoveNicNameButton(_ sender: Any) {
        nickNameTextField.text = ""
        if let nickname = nickNameTextField.text {
            delegate?.checkNicNameState(nickname: nickname)
        }
    }
    
}
extension ProfileUserInfoTVC : UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let nickname = textField.text {
            delegate?.checkNicNameState(nickname: nickname)
        }
        return true
        
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if let textCount = textField.text?.count{
            
            nicNameCountLabel.text = "\(textCount)"
        }
        if let nickname = textField.text {
            delegate?.checkNicNameState(nickname: nickname)
        }
       
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nickname = textField.text {
            
            delegate?.checkName(nickname: nickname,textField : self.nickNameTextField,label: self.nicknameStateLabel)
        }
        return true
    }
}
struct ProfileUserInfoTVCViewModel {
    let profileImage : String?
    let nickName : String
    let description : String?
    init(with model : ProfileResult){
        self.profileImage = model.profileURL
        self.nickName = model.nickname
        self.description = model.resultDescription
    }
}
