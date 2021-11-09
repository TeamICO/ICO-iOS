//
//  HokeywordSV.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/09.
//

import UIKit

class HokeywordSV: UIView {
    
    private let content = UIView()
    
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
