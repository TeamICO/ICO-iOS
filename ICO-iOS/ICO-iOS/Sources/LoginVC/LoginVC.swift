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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTransparent = true
        
        collectionViewConfigure()
        view.addSubview(appleButton)
        appleButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16).isActive = true
        appleButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -16).isActive = true
        appleButton.topAnchor.constraint(equalTo: kakaoLoginView.bottomAnchor,constant: 16).isActive = true
        appleButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
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
// MARK: - CollectionView Configure
extension LoginVC {
    func collectionViewConfigure(){
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: LoginCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: LoginCVC.identifier)
        
    }
}
extension LoginVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoginCVC.identifier, for: indexPath) as! LoginCVC
        cell.backgroundColor = UIColor.appColor(.categoryBackgroundGreen)
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
