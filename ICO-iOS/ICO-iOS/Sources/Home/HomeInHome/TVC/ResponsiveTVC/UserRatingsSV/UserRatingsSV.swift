//
//  UserRatingsSV.swift
//  ICO
//
//  Created by do_yun on 2021/11/07.
//

import UIKit

class UserRatingsSV: UIView {
    
    private let content : UIView = {
      let view = UIView()
        view.backgroundColor = UIColor.appColor(.userRatingIconGreen)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints =  false
        return view
    }()
    
    private let ratingIcon : UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "illust-product-vegan")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(content)
        content.addSubview(ratingIcon)
        setIconConfigure()
    }
    
    func setIconConfigure(){
        content.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        content.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        content.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        content.widthAnchor.constraint(equalToConstant: 16).isActive = true
        content.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        ratingIcon.centerYAnchor.constraint(equalTo: content.centerYAnchor).isActive = true
        ratingIcon.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
        ratingIcon.widthAnchor.constraint(equalToConstant: 11).isActive = true
        ratingIcon.heightAnchor.constraint(equalToConstant: 11).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
