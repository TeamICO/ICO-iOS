//
//  HomeInStyleLifeVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//

import UIKit

class HomeInStyleLifeVC: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet var categoryBtn: [UIButton]!
    
    
    let viewSizeWidth : CGFloat = 414
    let viewSizeWidth2 : CGFloat = 828
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI(){
        segmentView.backgroundColor = UIColor.lightShadow
        segmentView.cornerRadius = 16
        categoryBtn[0].setTitle("최신", for: .normal)
        categoryBtn[1].setTitle("인기", for: .normal)
        categoryBtn[2].setTitle("키워드", for: .normal)
      
        for i in 0...2{
            categoryBtn[i].setTitleColor(UIColor.tabBarGray, for: .normal)
            categoryBtn[i].setTitleColor(UIColor.black, for: .selected)
        }
    }
    
    
    @IBAction func recentBtn(_ sender: Any) {
        scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
    }
    
    
    @IBAction func popularBtn(_ sender: Any) {
        scrollView.setContentOffset(CGPoint(x: viewSizeWidth, y: 0.0), animated: true)
    }
    
    
    @IBAction func keywordBtn(_ sender: Any) {
        scrollView.setContentOffset(CGPoint(x: viewSizeWidth2, y: 0.0), animated: true)
    }
    

}


