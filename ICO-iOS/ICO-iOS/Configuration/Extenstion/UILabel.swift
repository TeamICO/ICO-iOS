//
//  UILabel.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/16.
//

import Foundation
import UIKit

extension UILabel{
    func setLabelConfigure(label : UILabel, styleShotCategoryType : String){
        switch styleShotCategoryType{
        case "비건" :
            label.textColor = UIColor.alertsSuccess
            label.backgroundColor = UIColor.lightSuccess
            break
        case "업사이클링":
            label.textColor = UIColor.coGreen90
            label.backgroundColor = UIColor.coGreen5
            break
        case "에너지절약":
            label.textColor = UIColor.alertsInfo
            label.backgroundColor = UIColor.lightInfo
            break
        case "제로웨이스트":
            label.textColor = UIColor.alertWarning
            label.backgroundColor = UIColor.lightWarning
            break
        case "클린뷰티":
            label.textColor = UIColor.dirtGreen
            label.backgroundColor = UIColor.lightShadow
            break
        case "유기농":
            label.textColor = UIColor.alertsError
            label.backgroundColor = UIColor.lightError
            break
        case "가치":
            label.textColor = UIColor.point
            label.backgroundColor = UIColor.lightPoint
            break
        default:
            break
        }
    }
}
