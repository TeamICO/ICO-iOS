//
//  ProfileUserInfoTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/11.
//

import UIKit
protocol ProfileUserInfoTVCDelegate: AnyObject {
    func didTapUserImageView()
}

class ProfileUserInfoTVC: UITableViewCell {
    static let identifier = "ProfileUserInfoTVC"
    
    weak var delegate : ProfileUserInfoTVCDelegate?
    
    @IBOutlet weak var userImageView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nicNameTextField: UITextField!
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
        nicNameTextField.text = nil
    }
    func configure(with viewModel : ProfileUserInfoTVCViewModel){
        self.nicNameTextField.text = viewModel.nicName
        guard let url = URL(string: viewModel.profileImage) else{
                return
            }
        DispatchQueue.global().async {
                let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                    guard let data = data else{
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self?.userImage.image = UIImage(data: data)
                    }
                }
                task.resume()
        }
    }
    func textfieldConfigure(){
        nicNameTextField.leftViewMode = .always
        nicNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        nicNameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.appColor(.feedbackTextColor)])
        nicNameTextField.delegate = self
    }
    func setUserImageViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapUserImageView))
        viewTap.cancelsTouchesInView = false
        userImageView.addGestureRecognizer(viewTap)
    }
    @objc func didTapUserImageView(){
        delegate?.didTapUserImageView()
    }

    @IBAction func didTapRemoveNicNameButton(_ sender: Any) {
        nicNameTextField.text = ""
    }
    
}
extension ProfileUserInfoTVC : UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let textCount = textField.text?.count{
            nicNameCountLabel.text = "\(textCount)"
        }
       
    }
}
struct ProfileUserInfoTVCViewModel {
    let profileImage : String
    let nicName : String
    let description : String
    init(with model : ProfileResult){
        self.profileImage = model.profileURL
        self.nicName = model.nickname
        self.description = model.resultDescription
    }
}
