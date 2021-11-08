//
//  LoginVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/08.
//

import UIKit
import AuthenticationServices

@available(iOS 13.0,*)
class LoginVC: UIViewController {
    var nowPage = 0
    
    // MARK: - Properties
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
        self.navigationController?.navigationBar.isTransparent = true
        
        collectionViewConfigure()
        setAppleLoginCofigure()
        setNaverViewTapGesture()
        setKakaoViewTapGesture()
        bannerTimer()
    }
    
  
  

}
// MARK: - CollectionView Configure
extension LoginVC {
    func collectionViewConfigure(){
        
        
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
        return CGSize(width: view.frame.size.width, height: 398)
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
//MARK : 카카오 뷰
extension LoginVC {
    func setNaverViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapNaverView))
        viewTap.cancelsTouchesInView = false
        naverLoignView.addGestureRecognizer(viewTap)
    }
    @objc func didTapNaverView(){
        print("네이버")
        UserDefaults.standard.set("qwewqe",forKey: "jwtToken")
        let vc = BaseTBC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

//MARK : 네이버 뷰
extension LoginVC {
    func setKakaoViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapKakaoView))
        viewTap.cancelsTouchesInView = false
        kakaoLoginView.addGestureRecognizer(viewTap)
    }
    @objc func didTapKakaoView(){
        print("카카오")
        UserDefaults.standard.set("qwewqe",forKey: "jwtToken")
        let vc = BaseTBC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
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
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            if let authorizationCode = appleIDCredential.authorizationCode,
                let identityToken = appleIDCredential.identityToken,
               let authString = String(data: authorizationCode, encoding: .utf8),
                let tokenString = String(data: identityToken, encoding: .utf8) {
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authString: \(authString)")
                print("tokenString: \(tokenString)")
                
            }
            print("useridentifier: \(userIdentifier)")
            print("fullName: \(fullName)")
            print("email: \(email)")
        case let passwordCredential as ASPasswordCredential:
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            print("username: \(username)")
            print("password: \(password)") default: break
            
        }
        
    }
    // 로그인 실패시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("--login err")
        
    }

    
}

// MARK: - Banner Scolling
extension LoginVC {
    func bannerTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (Timer) in
            self.bannerMove()
        }
    }
    // 배너 움직이는 매서드
    func bannerMove() {
        // 현재페이지가 마지막 페이지일 경우
        if nowPage == titleLabels.count-1 {
            // 맨 처음 페이지로 돌아감
            collectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
            nowPage = 0
            return
        }
        // 다음 페이지로 전환
        nowPage += 1
        collectionView.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .right, animated: true)
    }
    
}

