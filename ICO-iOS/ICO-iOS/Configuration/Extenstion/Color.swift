//
//  Color.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//
import Foundation
import UIKit

extension UIColor {
    // MARK: hex code를 이용하여 정의
    // ex. UIColor(hex: 0xF5663F)
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
    // ex. label.textColor = .mainOrange
    class var mainOrange: UIColor { UIColor(hex: 0xF5663F) }
    class var tabBarGray: UIColor {UIColor(hex: 0x8d8e8f) }
    class var tabBarGreen: UIColor {UIColor(hex: 0x81ec62)}
    class var upcyclingGreen: UIColor {UIColor(hex: 0x005834)}
    class var iGreen: UIColor {UIColor(hex: 0x4CE126)}
    class var coGreen: UIColor {UIColor(hex: 0x058954)}
    class var coGreen5: UIColor {UIColor(hex: 0xEDFCF4)}
    class var coGreen10: UIColor {UIColor(hex: 0xC0E4D1)}
    class var coGreen30: UIColor {UIColor(hex: 0x6BC396)}
    class var coGreen60: UIColor {UIColor(hex: 0x17AA6B)}
    class var coGreen70: UIColor {UIColor(hex: 0x00BB0F)}
    class var coGreen90: UIColor {UIColor(hex: 0x005834)}
    
    class var gradient01: UIColor {UIColor(hex: 0x6BC396)}
    class var gradient012: UIColor {UIColor(hex: 0x64E126)}

    class var backGround1: UIColor {UIColor(hex: 0x99F3F8F7)}
    class var backGround2: UIColor {UIColor(hex: 0xFFFFFF)}
    class var primaryBlack10: UIColor {UIColor(hex: 0xF4F6F6)}
    class var primaryBlack20: UIColor {UIColor(hex: 0xE8EAEA)}
    class var primaryBlack30: UIColor {UIColor(hex: 0xD9DADB)}
    class var primaryBlack40: UIColor {UIColor(hex: 0xC4C5C6)}
    class var primaryBlack50 :UIColor {UIColor(hex: 0x9E9FA0)}
    class var primaryBlack60: UIColor {UIColor(hex: 0x7C7D7D)}
    class var primaryBlack70: UIColor {UIColor(hex: 0x555757)}
    class var primaryBlack80: UIColor {UIColor(hex: 0x434545)}
    class var primaryBlack90: UIColor {UIColor(hex: 0x262828)}
    class var primaryigreen5: UIColor {UIColor(hex: 0xEDFCE8)}
    class var lightBackground: UIColor {UIColor(hex: 0xF9F9F9)}
    class var lightShadow: UIColor {UIColor(hex: 0xF3F8F7)}
    class var alertsError: UIColor {UIColor(hex: 0xEF5A5A)}
    class var alertsSuccess: UIColor {UIColor(hex: 0x21C713)}
    class var alertWarning: UIColor {UIColor(hex: 0xF19A54)}
    class var alertsInfo: UIColor {UIColor(hex: 0x1A8EE1)}
    class var point: UIColor {UIColor(hex: 0xF4C006)}
    class var lightError: UIColor {UIColor(hex: 0xFFF3F3)}
    class var lightSuccess: UIColor {UIColor(hex: 0xF3FFEC)}
    class var lightWarning: UIColor {UIColor(hex: 0xFFF7EF)}
    class var lightInfo: UIColor {UIColor(hex: 0xF1FBFF)}
    class var lightPoint: UIColor {UIColor(hex: 0xFFFBE3)}
    static func appColor(_ name: Colors) -> UIColor {
        switch name {
        case .customGreen :
            return #colorLiteral(red: 0, green: 0.7332608104, blue: 0.04968415946, alpha: 1)
        case .userRatingIconGreen :
            return #colorLiteral(red: 0.9294117647, green: 0.9882352941, blue: 0.9098039216, alpha: 1)
        case .tableViewFooterColor :
            return #colorLiteral(red: 0.9621332288, green: 0.977820456, blue: 0.9751018882, alpha: 0.6)
        case .categoryFontRed :
            return #colorLiteral(red: 0.937254902, green: 0.3529411765, blue: 0.3529411765, alpha: 1)
        case .categoryBackgroundRed :
            return #colorLiteral(red: 1, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        case .categoryFontGreen :
            return #colorLiteral(red: 0.262745098, green: 0.4156862745, blue: 0.4156862745, alpha: 1)
        case .categoryBackgroundGreen :
            return #colorLiteral(red: 0.9529411765, green: 0.9725490196, blue: 0.968627451, alpha: 1)
        case .homeBestButtonBackground :
            return #colorLiteral(red: 0.9529411765, green: 0.9725490196, blue: 0.968627451, alpha: 1)
        case .tabBarTitleSeletedColor :
            return #colorLiteral(red: 0.003921568627, green: 0.01176470588, blue: 0.01176470588, alpha: 1)
        case .tabBarTitleUnSeletedColor :
            return #colorLiteral(red: 0.768627451, green: 0.7725490196, blue: 0.7764705882, alpha: 1)
        case .hotKeywordNumGreen:
            return #colorLiteral(red: 0.4196078431, green: 0.7647058824, blue: 0.5882352941, alpha: 1)
        case .hotKeywordStringBlack :
            return #colorLiteral(red: 0.003921568627, green: 0.01176470588, blue: 0.01176470588, alpha: 1)
        case .alertGreen :
            return #colorLiteral(red: 0.01960784314, green: 0.537254902, blue: 0.3294117647, alpha: 1)
        case .feedbackButtoncolor1 :
            return #colorLiteral(red: 0.4196078431, green: 0.7647058824, blue: 0.5882352941, alpha: 1)
        case .feedbackButtoncolor2 :
            return #colorLiteral(red: 0.3921568627, green: 0.8823529412, blue: 0.1490196078, alpha: 1)
        case .feedbackTextColor :
            return #colorLiteral(red: 0.6196078431, green: 0.6235294118, blue: 0.6274509804, alpha: 1)
        case .feedbackinpuTextColor :
            return #colorLiteral(red: 0.003921568627, green: 0.01176470588, blue: 0.01176470588, alpha: 1)
        case .feedbackBackgroundColor :
            return #colorLiteral(red: 0.9529411765, green: 0.9725490196, blue: 0.968627451, alpha: 0.6)
        case .feedbackTintColor :
            return #colorLiteral(red: 0.09019607843, green: 0.6666666667, blue: 0.4196078431, alpha: 1)
        case .alertRed:
            return #colorLiteral(red: 0.937254902, green: 0.3529411765, blue: 0.3529411765, alpha: 1)
        case .alertBlack:
            return #colorLiteral(red: 0.3333333333, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        case .tableViewCellColor:
            return #colorLiteral(red: 0.9294117647, green: 0.9882352941, blue: 0.9098039216, alpha: 1)
        }
        
        
    }
    
}


enum Colors {
    case customGreen
    case tableViewFooterColor
    case categoryFontRed
    case categoryBackgroundRed
    case categoryFontGreen
    case categoryBackgroundGreen
    case homeBestButtonBackground
    case userRatingIconGreen
    case tabBarTitleSeletedColor
    case tabBarTitleUnSeletedColor
    case hotKeywordNumGreen
    case hotKeywordStringBlack
    case alertGreen
    case alertRed
    case alertBlack
    case feedbackButtoncolor1
    case feedbackButtoncolor2
    case feedbackTextColor
    case feedbackinpuTextColor
    case feedbackBackgroundColor
    case feedbackTintColor
    case tableViewCellColor
    
    
 
}
