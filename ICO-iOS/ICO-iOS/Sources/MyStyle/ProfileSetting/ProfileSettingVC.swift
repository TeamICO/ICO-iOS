//
//  ProfileSettingVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/10.
//

import UIKit
import Photos

class ProfileSettingVC: BaseViewController {
    // MARK: - Properties
    private var profileModel : ProfileResult?
    private var ecokeywords = [ProfileEcoKeyword]()
    private var seletedKeywords = [Int]()
    private var userNickname = ""
    private var nickname = ""
    private var isCheckedNickname = false
    private var profileDescription = ""
    private var selectedContentImage : String?
    @IBOutlet weak var updateView: UIView!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardWhenTappedAround()
        tableviewConfigure()
        configure()
        fetchData()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setBlurEffect(view: topView)
    }
    
    // MARK: - Selectors
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func didTapUpdateButton(_ sender: Any) {
        guard !self.seletedKeywords.isEmpty else{
            self.presentAlert(title: "관심 키워드를 선택해주세요.")
            return
        }
        guard !self.nickname.isEmpty else{
            self.presentAlert(title: "닉네임을 입력해주세요.")
            return
        }
        if self.userNickname == self.nickname{
            isCheckedNickname = true
        }
        guard isCheckedNickname else{
            self.presentAlert(title: "닉네임을 조건에 맞게입력해주세요.")
            return
        }
        guard let jwtToken = self.jwtToken else{
            return
        }
        let ecokeywords = self.seletedKeywords.map{String($0+1)}
        
        if let image = self.selectedContentImage{
            ProfileUpdateManager.shared.updateUserProfile(imageData: image,
                                                          nickname: self.nickname,
                                                          description: self.profileDescription,
                                                          activatedEcoKeyword: ecokeywords,
                                                          userIdx: self.userIdx,
                                                          jwtToken: jwtToken) { response in
                guard response.isSuccess else{
                    return
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }else{
            ProfileUpdateManager.shared.updateUserProfile(imageData: nil,
                                                          nickname: self.nickname,
                                                          description: self.profileDescription,
                                                          activatedEcoKeyword: ecokeywords,
                                                          userIdx: self.userIdx,
                                                          jwtToken: jwtToken) { response in
                guard response.isSuccess else{
                    return
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
 
    }
    
}
// MARK: - FetchData
extension ProfileSettingVC{
    func fetchData(){
        guard let jwtToken = self.jwtToken else{
            return
        }
        ProfileManager.shared.getUserProfile(userIdx: self.userIdx, jwtToken: jwtToken) { [weak self] response in
            guard let response = response,let des = response.resultDescription else {
                return
            }
            
            self?.profileModel = response
            self?.userNickname = response.nickname
            self?.nickname = response.nickname
            self?.selectedContentImage = response.profileURL
            self?.profileDescription = des
            let keywords = response.ecoKeyword.filter{$0.status.rawValue == "Y"}
            self?.ecokeywords = keywords
            for i in 0..<keywords.count{
                self?.seletedKeywords.append(keywords[i].ecoKeywordIdx-1)
            }
            
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
        if UIDevice.current.userInterfaceIdiom == .pad {
            updateButton.backgroundColor = .gradient01
        }else{
            updateButton.setGradient(color1: UIColor.appColor(.feedbackButtoncolor1), color2: UIColor.appColor(.feedbackButtoncolor2))
           
        }
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
        tableView.backgroundColor = .white
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
            cell.delegate = self
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
    func tapDonationView(seletedKeywords: [Int]) {
        self.seletedKeywords = seletedKeywords
        
    }
    
    func tapAnimalView(seletedKeywords: [Int]) {
        self.seletedKeywords = seletedKeywords
        
    }
    
    func tapTradeView(seletedKeywords: [Int]) {
        self.seletedKeywords = seletedKeywords
        
    }
    
    func tapVeganView(seletedKeywords: [Int]) {
        self.seletedKeywords = seletedKeywords
        
    }
    
    func tapLactoView(seletedKeywords: [Int]) {
        self.seletedKeywords = seletedKeywords
   
    }
    
    func tapLactovoView(seletedKeywords: [Int]) {
        self.seletedKeywords = seletedKeywords

    }
    
    func tapFescoView(seletedKeywords: [Int]) {
        self.seletedKeywords = seletedKeywords

    }
    
    func tapPlasticFreeView(seletedKeywords: [Int]) {
        self.seletedKeywords = seletedKeywords
    }
    
    func tapEcoView(seletedKeywords: [Int]) {
        self.seletedKeywords = seletedKeywords
       
    }
    
    func tapUpcyclingView(seletedKeywords: [Int]) {
        self.seletedKeywords = seletedKeywords
    
    }
    
    func tapPackageView(seletedKeywords: [Int]) {
        self.seletedKeywords = seletedKeywords
       
    }
    
    func tapGmoFreeView(seletedKeywords: [Int]) {
        self.seletedKeywords = seletedKeywords
 
    }
    
    func tapChemicalView(seletedKeywords: [Int]) {
        self.seletedKeywords = seletedKeywords
      
    }
    
    func tapFdaView(seletedKeywords: [Int]) {
        self.seletedKeywords = seletedKeywords
        
    }

    
    
}
//MARK : Iamge PIcker
extension ProfileSettingVC :ProfileUserInfoTVCDelegate{
    func didTapUserImageView(image: UIImageView) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: "프로필 사진 바꾸기", style: .default, handler:{ [weak self]_ in
            PHPhotoLibrary.requestAuthorization( { status in
                        switch status{
                        case .authorized:
                            print("Album: 권한 허용")
                            DispatchQueue.main.async {
                                let picker = UIImagePickerController()
                                picker.sourceType = .photoLibrary
                                picker.delegate = self
                                picker.allowsEditing = true
                                self?.present(picker, animated: true, completion: nil)
                            
                            }
                        case .denied:
                            print("Album: 권한 거부")
                        case .restricted, .notDetermined:
                            print("Album: 선택하지 않음")
                        default:
                            break
                        }
                    })
            
        })
        let action2 = UIAlertAction(title: "기본 이미지로 설정", style: .default, handler:nil)
        action.setValue(UIColor.coGreen, forKey: "titleTextColor")
        action2.setValue(UIColor.coGreen, forKey: "titleTextColor")
        actionSheet.addAction(action)
        actionSheet.addAction(action2)
 
        let cancel = UIAlertAction(title: "취소", style: .cancel,handler: {_ in
            self.tabBarController?.tabBar.isHidden = false
            
        })
        cancel.setValue(UIColor.appColor(.alertBlack), forKey: "titleTextColor")
        actionSheet.addAction(cancel)
        
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
        self.present(actionSheet, animated: true)

    }
    
    func checkNicNameState(nickname: String) {
        self.nickname = nickname
    }
    
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
                self.nickname = nickname
                return
            }
            textField.layer.borderWidth = 0.5
            textField.layer.borderColor = UIColor.alertsSuccess.cgColor
            label.textColor = UIColor.alertsSuccess
            label.text = result.message
            self.nickname = nickname
            self.isCheckedNickname = true
        }
    }
}
//MARK : Iamge PIcker Delegate
extension ProfileSettingVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage,
        let newImage = resizeImage(image: image, newWidth: 100) else{
            return
        }
        
        let imageId = UUID().uuidString
        BaseManager.shared.uploadImage(image: newImage, imageId: imageId) { success in
            guard success else{
                return
            }
            BaseManager.shared.downloadUrlForPostImage(imageId: imageId) { [weak self] url in
                guard let url = url else{
                    return
                }
                self?.selectedContentImage = "\(url)"
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            }
        }
        
    }
   func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

}
extension ProfileSettingVC : ProfileUserIntroductionTVCDelegate{
    func getTextViewText(text: String) {
        self.profileDescription = text
    }
    
    
}
