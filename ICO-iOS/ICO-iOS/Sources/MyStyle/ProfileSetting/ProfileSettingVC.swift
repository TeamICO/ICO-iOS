//
//  ProfileSettingVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/10.
//

import UIKit

class ProfileSettingVC: BaseViewController {
    // MARK: - Properties
    private var profileModel : ProfileResult?
    private var ecokeywords = [ProfileEcoKeyword]()
    
    private var selectedContentImage : UIImage?
    @IBOutlet weak var updateView: UIView!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableviewConfigure()
        configure()
        fetchData()
        
    }
   
    
    // MARK: - Selectors
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
// MARK: - FetchData
extension ProfileSettingVC{
    func fetchData(){
        guard let jwtToken = self.jwtToken else{
            return
        }
        ProfileManager.shared.getUserProfile(userIdx: self.userIdx, jwtToken: jwtToken) { [weak self] response in
            guard let response = response else {
                return
            }
            self?.profileModel = response
            self?.ecokeywords = response.ecoKeyword.filter{$0.status.rawValue == "Y"}
            self?.tableView.reloadData()
        }
    }
}

extension ProfileSettingVC{
    // MARK: - Configure
    func configure(){
        updateView.setVerticalGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: .white)
        updateButton.layer.cornerRadius = 12
        updateButton.layer.masksToBounds = true
        updateButton.setGradient(color1: UIColor.appColor(.feedbackButtoncolor1), color2: UIColor.appColor(.feedbackButtoncolor2))
    }
}
// MARK: - TableView Configure
extension ProfileSettingVC {
    func tableviewConfigure(){
        let userInfoNib = UINib(nibName: ProfileUserInfoTVC.identifier, bundle: nil)
        tableView.register(userInfoNib, forCellReuseIdentifier: ProfileUserInfoTVC.identifier)
        
        let userIntroNib = UINib(nibName: ProfileUserIntroductionTVC.identifier, bundle: nil)
        tableView.register(userIntroNib, forCellReuseIdentifier: ProfileUserIntroductionTVC.identifier)
        
        
        let ecoKeywordNib = UINib(nibName: ProfileMyEcoKeywordTVC.identifier, bundle: nil)
        tableView.register(ecoKeywordNib, forCellReuseIdentifier: ProfileMyEcoKeywordTVC.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = nil
        tableView.sectionHeaderHeight = 0
        tableView.separatorStyle = .none

    }
}
// MARK: - TableView Delegate, DataSource
extension ProfileSettingVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileUserInfoTVC.identifier, for: indexPath) as! ProfileUserInfoTVC
            cell.selectionStyle = .none
            cell.delegate = self
            if let profileModel = self.profileModel{
                cell.configure(with: ProfileUserInfoTVCViewModel(with: profileModel))
            }
            
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileUserIntroductionTVC.identifier, for: indexPath) as! ProfileUserIntroductionTVC
            cell.selectionStyle = .none
            if let profileModel = self.profileModel{
                cell.configure(with: ProfileUserInfoTVCViewModel(with: profileModel))
            }
            return cell
        case 2 :
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileMyEcoKeywordTVC.identifier, for: indexPath) as! ProfileMyEcoKeywordTVC
            cell.selectionStyle = .none
            cell.delegate = self
            cell.configure(keywords: self.ecokeywords)
            return cell
        default:
            return UITableViewCell()
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0 : return 246
        case 1 : return 157
        case 2 : return 420
        default : return 0
        }
       
    }


    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        switch section {
        case 2 : return UIView()
        default :
            let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 12))
            footer.backgroundColor = UIColor.appColor(.tableViewFooterColor)
            return footer
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 2 : return 0
        default : return 12
        }
    }

    
    
}
extension ProfileSettingVC : ProfileMyEcoKeywordTVCDelegate {
    func tapDonationView() {
        
    }
    
    func tapAnimalView() {
        
    }
    
    func tapTradeView() {
        
    }
    
    
}
//MARK : Iamge PIcker
extension ProfileSettingVC :ProfileUserInfoTVCDelegate{
    func checkName(nickname: String, textField: UITextField, label: UILabel) {
        guard let jwtToken = self.jwtToken else{
            return
        }
        NickNameManager.shared.checkNickName(nickname: nickname, jwtToken: jwtToken) { result in
            guard result.isSuccess else{
                textField.layer.borderWidth = 0.5
                textField.layer.borderColor = UIColor.alertsError.cgColor
                label.textColor = UIColor.alertsError
                label.text = result.message
            
                return
            }
            textField.layer.borderWidth = 0.5
            textField.layer.borderColor = UIColor.alertsSuccess.cgColor
            label.textColor = UIColor.alertsSuccess
            label.text = result.message
        }
    }
    

    
   
    
    func didTapUserImageView() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
}
//MARK : Iamge PIcker Delegate
extension ProfileSettingVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else{
            return
        }
        self.selectedContentImage = image
       
    }
    
    
}

