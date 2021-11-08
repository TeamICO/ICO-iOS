//
//  HomeVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//

import UIKit
enum State {
    case home
    case lifeStyle
}


class HomeVC: BaseViewController {
    // MARK: - Properties
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var lifeStyleButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
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
