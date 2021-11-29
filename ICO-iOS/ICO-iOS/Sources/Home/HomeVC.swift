//
//  HomeVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//

import UIKit
import AppTrackingTransparency

enum State {
    case home
    case lifeStyle
}


class HomeVC: BaseViewController{
    // MARK: - Properties
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var lifeStyleButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var alarmView: UIView!
    
    @IBOutlet weak var topView: UIView!
    
    
    let viewSizeWidth : CGFloat = UIScreen.main.bounds.width
    
    // 버튼 클릭시 폰트 색상 변경을 위한 상태 변수
    var isState : State = .home{
        didSet{
            switch isState{
            case .home:
                homeButton.tintColor = UIColor.appColor(.customGreen)
                lifeStyleButton.tintColor  = .lightGray
                break
            case .lifeStyle:
                homeButton.tintColor = .lightGray
                lifeStyleButton.tintColor  = UIColor.appColor(.customGreen)
                break
            }
        }
    }

    

    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
      
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self
//        requestTrackingAuthoriztion()
        configure()
        setLikeViewTapGesture()
        setAlarmViewTapGesture()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let blur = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = topView.bounds
        topView.addSubview(blurView)
        topView.sendSubviewToBack(blurView)
    }
    
    
    // MARK: - configure
    func configure(){
        homeButton.addTarget(self, action: #selector(didTapHomeButton), for: .touchUpInside)
        lifeStyleButton.addTarget(self, action: #selector(didTapLifeStyleButton), for: .touchUpInside)

        stackViewWidth.constant = viewSizeWidth
    }
    
    // MARK: - Selectors
    @objc func didTapHomeButton(sender: UIButton){
        scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
        isState = .home
    }
    @objc func didTapLifeStyleButton(sender: UIButton){
        scrollView.setContentOffset(CGPoint(x: viewSizeWidth, y: 0.0), animated: true)
        isState = .lifeStyle
    }


}
//MARK : 좋아요 뷰
extension HomeVC {
    func setLikeViewTapGesture(){
        
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapLikeView))
        viewTap.cancelsTouchesInView = false
        likeView.addGestureRecognizer(viewTap)
    }
    @objc func didTapLikeView(){
        self.navigationPushViewController(storyboard: "LikeSB", identifier: "LikeVC")
    }
}

//MARK : 알림 뷰
extension HomeVC {
    func setAlarmViewTapGesture(){
        
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapAlarmView))
        viewTap.cancelsTouchesInView = false
        alarmView.addGestureRecognizer(viewTap)
    }
    @objc func didTapAlarmView(){
        let storyboard = UIStoryboard(name: "AlarmSB", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AlarmVC") as! AlarmVC
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.complition = { taped in
            self.tabBarController?.selectedIndex = 1
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
//MAKR : 광고 식별자(IDFA)
extension HomeVC {
    func requestTrackingAuthoriztion(){
        if #available(iOS 14, *){
            ATTrackingManager.requestTrackingAuthorization { (status) in
                switch status{
                case .notDetermined:
                    print("notDetermined")
                case .restricted:
                    print("restricted")
                case .denied:
                    print("denied")
                case .authorized:
                    print("authorized")
                @unknown default:
                    print("error")
                }
            }
        }
    }
}
extension HomeVC : UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 0 {
            scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
            isState = .home
        }
    }
    
}
