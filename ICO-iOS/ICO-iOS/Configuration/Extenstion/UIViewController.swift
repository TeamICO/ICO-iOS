//
//  UIViewController.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//

import Foundation
import UIKit
import SnapKit

extension UIViewController {
    // MARK: 빈 화면을 눌렀을 때 키보드가 내려가도록 처리
    func dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    // MARK: 취소와 확인이 뜨는 UIAlertController
    func presentAlert(title: String, message: String? = nil,
                      isCancelActionIncluded: Bool = false,
                      preferredStyle style: UIAlertController.Style = .alert,
                      handler: ((UIAlertAction) -> Void)? = nil) {
        self.dismissIndicator()
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let actionDone = UIAlertAction(title: "확인", style: .default, handler: handler)
        actionDone.setValue(UIColor.coGreen, forKey: "titleTextColor")
        alert.addAction(actionDone)
        if isCancelActionIncluded {
            let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(actionCancel)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: 커스텀 UIAction이 뜨는 UIAlertController
    func presentAlert(title: String, message: String? = nil,
                      isCancelActionIncluded: Bool = false,
                      preferredStyle style: UIAlertController.Style = .alert,
                      with actions: UIAlertAction ...) {
        self.dismissIndicator()
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { alert.addAction($0) }
        if isCancelActionIncluded {
            let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(actionCancel)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: UIWindow의 rootViewController를 변경하여 화면전환
    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    
    // MARK: 커스텀 하단 경고창
    func presentBottomAlert(message: String, target: ConstraintRelatableTarget? = nil, offset: Double? = -12) {
        let alertSuperview = UIView()
        alertSuperview.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        alertSuperview.layer.cornerRadius = 10
        alertSuperview.isHidden = true
    
        let alertLabel = UILabel()
        alertLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 20)
        alertLabel.textColor = UIColor.appColor(.alertRed)
        alertLabel.backgroundColor = .white
        
        self.view.addSubview(alertSuperview)
        alertSuperview.snp.makeConstraints { make in
            make.bottom.equalTo(target ?? self.view.safeAreaLayoutGuide).offset(-12)
            make.centerX.equalToSuperview()
        }
        
        alertSuperview.addSubview(alertLabel)
        alertLabel.snp.makeConstraints { make in
            make.top.equalTo(6)
            make.bottom.equalTo(-6)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
        }
        
        alertLabel.text = message
        alertSuperview.alpha = 1.0
        alertSuperview.isHidden = false
        UIView.animate(
            withDuration: 2.0,
            delay: 1.0,
            options: .curveEaseIn,
            animations: { alertSuperview.alpha = 0 },
            completion: { _ in
                alertSuperview.removeFromSuperview()
            }
        )
    }
    
    // MARK: 인디케이터 표시
    func showIndicator() {
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
    }
    
    // MARK: 인디케이터 숨김
    @objc func dismissIndicator() {
        IndicatorView.shared.dismiss()
    }
    
    // MARK: 네비게이션 pushViewController
    func navigationPushViewController(storyboard : String, identifier : String){
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: identifier)
        vc.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func setBlurEffect(view : UIView){
        let blur = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = view.bounds
        view.addSubview(blurView)
        view.sendSubviewToBack(blurView)
    }
    func showCustomAlert(alert : CustomAlert,button : UIButton){
        let textwidth : CGFloat = 258
        alert.frame = CGRect(x: view.width/2-textwidth/2, y: button.top+10, width: textwidth, height: 38)
        view.addSubview(alert)
        view.bringSubviewToFront(button)
        UIView.animate(withDuration: 0.5) {
            alert.frame = CGRect(x: self.view.width/2-textwidth/2, y: button.top-50, width: textwidth, height: 38)
        } completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    UIView.animate(withDuration: 0.5) {
                        alert.frame = CGRect(x: self.view.width/2-textwidth/2, y: button.top+10, width: textwidth, height: 38)
                    } completion: { done in
                        if done {
                            alert.removeFromSuperview()
                        }
                    }

                }
            }
       
        }

        
    }
    public func checkInternet(){
        if !NetworkManager.shared.isConnected {
            let storyboard = UIStoryboard(name: "CustomInternetCheckSB", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "CustomInternetPopupVC") as! CustomInternetPopupVC
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true){
                DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                    vc.dismiss(animated: true, completion: nil)
                }
            }
       

        }
    }
   
}
