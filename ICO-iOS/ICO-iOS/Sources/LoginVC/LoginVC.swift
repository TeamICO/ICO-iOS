//
//  LoginVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/08.
//

import UIKit
import AuthenticationServices
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin
import Alamofire
import DeviceKit
import FirebaseMessaging
class LoginVC: UIViewController {
    var nowPage = 0
    
    // MARK: - Properties
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    private var appleIdentifier = ""
    
    private let titleLabels = [
        "당신의\n에코 라이프스타일을\n공유해보세요.",
        "다양한 친환경 제품의\n솔직한 후기를\n찾아볼 수 있어요.",
        "에코슈머로서\n가치있는 라이프를\n기록해보세요.",
        "나의 선한 영향력을\n직관적으로 보여줘요."
    ]
    private let subTitleLabels = [
        "가치있는 사람들의 가치있는\n라이프스타일을 함께 나눠봐요!",
        "여러 에코 리뷰들을 찾아보고, 쇼핑 꿀정보 획득!",
        "나의 프로필에서 나만의 에코\n라이프의 스타일샷을 기록해요!",
        "스타일샷을 등록하면 내가 환경에 끼친 영향력이 자동 업데이트돼요!"
    ]
    private let images  = [ "illust-character",
                            "illust-onboarding-info",
                            "illust-onboarding-shots",
                            "illust-earth"
    
    ]
    @IBOutlet weak var onboardingHeight: NSLayoutConstraint!
    @IBOutlet weak var personalAgreeButton: UIButton!
    @IBOutlet weak var serviceAgreeButton: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var naverLoignView: UIView!
    @IBOutlet weak var kakaoLoginView: UIView!
    
    private let appleButton : ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        button.addTarget(self, action: #selector(didTapAppleLogin), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeightOnboarding()
        self.navigationController?.navigationBar.isTransparent = true
        
        collectionViewConfigure()
        setAppleLoginCofigure()
        setNaverViewTapGesture()
        setKakaoViewTapGesture()
        setAgreeButtons()
        
    }
    @IBAction func didTapPersonalAgreeButton(_ sender: Any) {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationPushViewController(storyboard: "PersonalInfoTermsSB", identifier: "PersonalInfoTermsVC")
    }
    
    @IBAction func didTapServiceAgreeButton(_ sender: Any) {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationPushViewController(storyboard: "ServiceTermSB", identifier: "ServiceTermVC")
    }
    
   

}
// MARK: - OnBoarding Configure
extension LoginVC {
    func setHeightOnboarding(){
        if Device.current.isOneOf(IPhoneDeviceGroup.groupOfAllowedDevices) {
            onboardingHeight.constant = 328
        }else{
            onboardingHeight.constant = 398
        }
    }
}
// MARK: - CollectionView Configure
extension LoginVC {
    func collectionViewConfigure(){
        collectionView.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: LoginCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: LoginCVC.identifier)
        
    }
    @objc func didTapAppleLogin(){
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName,.email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}
extension LoginVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleLabels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoginCVC.identifier, for: indexPath) as! LoginCVC

        cell.titleLabel.text = titleLabels[indexPath.row]
        cell.subTitleLabel.text = subTitleLabels[indexPath.row]
        cell.imageView.image = UIImage(named: images[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
      
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if Device.current.isOneOf(IPhoneDeviceGroup.groupOfAllowedDevices) {
            return CGSize(width: view.frame.size.width, height: 328)
        }else{
            return CGSize(width: view.frame.size.width, height: 398)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        pageControl.currentPage = Int(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width))
        
        
    }
    
}
//MARK : 네이버
extension LoginVC {
    func setNaverViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapNaverView))
        viewTap.cancelsTouchesInView = false
        naverLoignView.addGestureRecognizer(viewTap)
      
    }
    @objc func didTapNaverView(){

        loginInstance?.delegate = self
        loginInstance?.requestThirdPartyLogin()
    }
    private func getNaverInfo() {
        
        guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else{
            return
        }
        
           if !isValidAccessToken {
               
             return
           }
        
        guard let tokenType = loginInstance?.tokenType else { return }
        guard let accessToken = loginInstance?.accessToken else { return }
        var deviceToken = ""
        Messaging.messaging().token { token, error in
            guard let token = token else{
                return
            }
            deviceToken = token
            LoginManager.shared.registerID(name: nil,snsToken: accessToken, snsType: "naver",deviceToken: deviceToken) { response in
                guard let jwt = response?.result.jwt,
                      let code = response?.code,
                      let name = response?.result.nickname,
                      let userIdx = response?.result.userIdx else{
                          return
                      }
                    
                UserDefaults.standard.set(jwt, forKey: "jwtToken")
                UserDefaults.standard.set(userIdx, forKey: "userIdx")
                UserDefaults.standard.set(name, forKey: "nickname")
                        DispatchQueue.main.async {
                            if code == 1001{
                                
                                let surveySB = UIStoryboard(name: "Survey", bundle: nil)
                                guard let surveyVC = surveySB.instantiateViewController(withIdentifier: "SurveyVC")as? SurveyVC else {return}
                                surveyVC.name = name
                                surveyVC.userIdx = userIdx
                                self.navigationController?.pushViewController(surveyVC, animated: true)
                            }else if code == 1002{
                                let storyboard = UIStoryboard(name: "MainSB", bundle: nil)
                         
                                let baseTBC = storyboard.instantiateViewController(identifier: "BaseTBC")
                                let vc = baseTBC
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true, completion: nil)
                            }
                           

                
                            
                        }
                  }
        }
        
         
    }
}

extension LoginVC: NaverThirdPartyLoginConnectionDelegate {
  // 로그인 버튼을 눌렀을 경우 열게 될 브라우저
  func oauth20ConnectionDidOpenInAppBrowser(forOAuth request: URLRequest!) {
//     let naverSignInVC = NLoginThirdPartyOAuth20InAppBrowserViewController(request: request)!
//     naverSignInVC.parentOrientation = UIInterfaceOrientation(rawValue: UIDevice.current.orientation.rawValue)!
//     present(naverSignInVC, animated: false, completion: nil)
  }
  
  // 로그인에 성공했을 경우 호출
  func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
    print("[Success] : Success Naver Login")
    getNaverInfo()
  }
  
  // 접근 토큰 갱신
  func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
    
  }
  
  // 로그아웃 할 경우 호출(토큰 삭제)
  func oauth20ConnectionDidFinishDeleteToken() {
    loginInstance?.requestDeleteToken()
  }
  
  // 모든 Error
  func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
    print("[Error] :", error.localizedDescription)
  }
}

//MARK : 카카오
extension LoginVC {
    func setKakaoViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapKakaoView))
        viewTap.cancelsTouchesInView = false
        kakaoLoginView.addGestureRecognizer(viewTap)
    }
    @objc func didTapKakaoView(){
        var deviceToken = ""
       
        Messaging.messaging().token { token, error in
            guard let token = token else{
                return
            }
            deviceToken = token
            self.showIndicator()
            LoginManager.shared.KakaoSignIn { response in
                guard let response = response else{
                    return
                }
                    LoginManager.shared.registerID(name : nil,snsToken: response, snsType: "kakao",deviceToken: deviceToken) { response in
                      
                        guard let jwt = response?.result.jwt,
                                  let code = response?.code,
                                  let name = response?.result.nickname,
                                  let userIdx = response?.result.userIdx else{
                            return
                        }
                        self.dismissIndicator()
                        UserDefaults.standard.set(jwt, forKey: "jwtToken")
                        UserDefaults.standard.set(userIdx, forKey: "userIdx")
                        UserDefaults.standard.set(name, forKey: "nickname")
                        DispatchQueue.main.async {
                            self.dismissIndicator()
                            if code == 1001{
                                let surveySB = UIStoryboard(name: "Survey", bundle: nil)
                                guard let surveyVC = surveySB.instantiateViewController(withIdentifier: "SurveyVC")as? SurveyVC else {return}
                                surveyVC.name = name
                                surveyVC.userIdx = userIdx
                                self.navigationController?.pushViewController(surveyVC, animated: true)
                            }else if code == 1002{
                                let storyboard = UIStoryboard(name: "MainSB", bundle: nil)
                         
                                let baseTBC = storyboard.instantiateViewController(identifier: "BaseTBC")
                                let vc = baseTBC
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true, completion: nil)
                                
                            }
                            
                        }

                    }
                    self.setUserInfo()
            }
        }

    }

    func setUserInfo(){
        UserApi.shared.me { user, error in
            guard let user = user, error == nil else{
                print("카카오톡 user 실패")
                return
            }
            
            let email = user.kakaoAccount?.email
            let nickname = user.kakaoAccount?.profile?.nickname
            
        }
    }
}

//MARK : 애플 로그인 설정
extension LoginVC{
    func setAppleLoginCofigure(){
        view.addSubview(appleButton)
        appleButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16).isActive = true
        appleButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -16).isActive = true
        appleButton.topAnchor.constraint(equalTo: kakaoLoginView.bottomAnchor,constant: 16).isActive = true
        appleButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
    }
}
extension LoginVC : ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    // 로그인 성공
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            self.appleIdentifier = userIdentifier
            let fullName = appleIDCredential.fullName
            if let identityToken = appleIDCredential.identityToken,
                let tokenString = String(data: identityToken, encoding: .utf8) {
                var deviceToken = ""
                print(tokenString)
                Messaging.messaging().token { token, error in
                    guard let token = token else{
                        return
                    }
                    deviceToken = token
                    var name : String?
                    if let familyName = fullName?.familyName, let givenName = fullName?.givenName{
                        name = "\(familyName)"+"\(givenName)"
                    }else{
                        name = nil
                    }
                    LoginManager.shared.registerID(name : name,snsToken: tokenString, snsType: "apple",deviceToken: deviceToken) { response in
                        guard let jwt = response?.result.jwt,
                              let code = response?.code,
                              let name = response?.result.nickname,
                              let userIdx = response?.result.userIdx  else{
                            return
                        }
                        UserDefaults.standard.set(jwt, forKey: "jwtToken")
                        UserDefaults.standard.set(userIdx, forKey: "userIdx")
                        UserDefaults.standard.set(name, forKey: "nickname")
                        DispatchQueue.main.async {
                            if code == 1001{
                                let surveySB = UIStoryboard(name: "Survey", bundle: nil)
                                guard let surveyVC = surveySB.instantiateViewController(withIdentifier: "SurveyVC")as? SurveyVC else {return}
                                surveyVC.name = name
                                surveyVC.userIdx = userIdx
                                self.navigationController?.pushViewController(surveyVC, animated: true)
                            }else if code == 1002{
                                let storyboard = UIStoryboard(name: "MainSB", bundle: nil)
                         
                                let baseTBC = storyboard.instantiateViewController(identifier: "BaseTBC")
                                let vc = baseTBC
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true, completion: nil)
                            }

                        }
                    }
                }
            }

           
        default: break
            
        }
        
    }
    // 로그인 실패시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("--login err")
        
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        
        appleIDProvider.getCredentialState(forUserID: self.appleIdentifier) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                // The Apple ID credential is valid.
                print("해당 ID는 연동되어있습니다.")
            case .revoked:
                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                print("해당 ID는 연동되어있지않습니다.")
            case .notFound:
                // The Apple ID credential is either was not found, so show the sign-in UI.
                print("해당 ID를 찾을 수 없습니다.")
            default:
                break
            }
        }
        return true
    }
    
}
extension LoginVC {
    func setAgreeButtons(){
        personalAgreeButton.setAttributedTitle("개인정보처리방침 보기".underLineThrough(), for: .normal)
        serviceAgreeButton.setAttributedTitle("서비스 이용 약관 보기".underLineThrough(), for: .normal)
    }
    
    
}
