//
//  CustomAlert.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/12/01.
//

import Foundation
import UIKit


struct CustomAlerViewmoel{
    let text : String
}

class CustomAlert : UIView{
    
    let viewModel : CustomAlerViewmoel
    
    lazy var label : UILabel = {
       let label = UILabel()
        label.textColor = .coGreen60
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        return label
    }()
    
    init(viewModel : CustomAlerViewmoel,frame : CGRect){
        self.viewModel = viewModel
        super.init(frame: frame)
        
        addSubview(label)
        configure()

    }
  
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(){
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 16
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.42, green: 0.765, blue: 0.588, alpha: 1).cgColor
        label.text = viewModel.text
    }
 
}
