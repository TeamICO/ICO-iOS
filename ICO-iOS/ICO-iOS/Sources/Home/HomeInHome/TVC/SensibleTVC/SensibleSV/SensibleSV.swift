//
//  SensibleSV.swift
//  ICO
//
//  Created by do_yun on 2021/11/03.
//

import UIKit

class SensibleSV: UIView {
    
    
    lazy var categoryLabel : BasePaddingLabel = {
       let label = BasePaddingLabel()
        label.text = "유기농"
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        label.textColor = UIColor.appColor(.categoryFontRed)
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor.appColor(.categoryBackgroundRed)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
  
        
        self.addSubview(categoryLabel)
        
        categoryLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        categoryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
