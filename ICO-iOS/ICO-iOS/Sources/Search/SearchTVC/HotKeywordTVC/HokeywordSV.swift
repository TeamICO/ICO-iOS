//
//  HokeywordSV.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/09.
//

import UIKit

class HokeywordSV: UIView {
    
    private let content = UIView()
    
    lazy var rankLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        label.textColor = UIColor.appColor(.hotKeywordNumGreen)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var rankTitleLabel : UILabel = {
       let label = UILabel()
        
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        label.textColor = UIColor.appColor(.hotKeywordStringBlack)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(content)
        
        configure()
    }
    func configure(){
        content.translatesAutoresizingMaskIntoConstraints = false
        content.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        content.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        content.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        content.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        content.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        content.addSubview(rankLabel)
        rankLabel.leftAnchor.constraint(equalTo: content.leftAnchor,constant: 16).isActive = true
        rankLabel.topAnchor.constraint(equalTo: content.topAnchor).isActive = true
        rankLabel.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        content.addSubview(rankTitleLabel)
        rankTitleLabel.leftAnchor.constraint(equalTo: rankLabel.rightAnchor,constant: 16).isActive = true
        rankTitleLabel.rightAnchor.constraint(equalTo: content.rightAnchor).isActive = true
        rankTitleLabel.topAnchor.constraint(equalTo: content.topAnchor,constant: 3).isActive = true
        rankTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
