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
    @IBOutlet weak var animateView: UIView!
    
    @IBOutlet weak var left: NSLayoutConstraint!
    @IBOutlet weak var right: NSLayoutConstraint!
    
    let viewSizeWidth : CGFloat = 414
    let viewSizeWidth2 : CGFloat = 828

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.segmentView.width/3)
        setUI()
    }
    
    func setUI(){
        segmentView.backgroundColor = UIColor.primaryBlack10
        segmentView.cornerRadius = 16
        
        animateView.cornerRadius = 16
        animateView.layer.shadowOpacity = 1
        animateView.layer.shadowColor = UIColor.init(red: 0.288, green: 0.288, blue: 0.288, alpha: 0.1).cgColor
        animateView.layer.shadowRadius = 13
        animateView.layer.shadowOffset = CGSize(width: 8, height: 8)
        
        categoryBtn[0].setTitle("최신", for: .normal)
        categoryBtn[0].setTitleColor(UIColor.black, for: .normal)
        categoryBtn[1].setTitle("인기", for: .normal)
        categoryBtn[1].setTitleColor(UIColor.tabBarGray, for: .normal)
        categoryBtn[2].setTitle("키워드별", for: .normal)
        categoryBtn[2].setTitleColor(UIColor.tabBarGray, for: .normal)
      
    }
    
    
    @IBAction func recentBtn(_ sender: Any) {
        scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
        categoryBtn[0].setTitleColor(UIColor.black, for: .normal)
        categoryBtn[1].setTitleColor(UIColor.tabBarGray, for: .normal)
        categoryBtn[2].setTitleColor(UIColor.tabBarGray, for: .normal)
        UIView.animate(withDuration: 1){
            self.left.constant = 6
            self.right.constant = (self.segmentView.width/3)*2
        }
    }
    
    
    @IBAction func popularBtn(_ sender: Any) {
        scrollView.setContentOffset(CGPoint(x: viewSizeWidth, y: 0.0), animated: true)
        categoryBtn[1].setTitleColor(UIColor.black, for: .normal)
        categoryBtn[0].setTitleColor(UIColor.tabBarGray, for: .normal)
        categoryBtn[2].setTitleColor(UIColor.tabBarGray, for: .normal)
        UIView.animate(withDuration: 1){
            self.left.constant = self.segmentView.width/3
            self.right.constant = self.segmentView.width/3
        }
    }
    
    
    @IBAction func keywordBtn(_ sender: Any) {
        scrollView.setContentOffset(CGPoint(x: viewSizeWidth2, y: 0.0), animated: true)
        categoryBtn[2].setTitleColor(UIColor.black, for: .normal)
        categoryBtn[0].setTitleColor(UIColor.tabBarGray, for: .normal)
        categoryBtn[1].setTitleColor(UIColor.tabBarGray, for: .normal)
        UIView.animate(withDuration: 1){
            self.left.constant = (self.segmentView.width/3)*2
            self.right.constant = 6
            self.categoryBtn[2].bringSubviewToFront(self.animateView)
        }
    }
    
    
    

}


