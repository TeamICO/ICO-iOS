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

    class var iGreen: UIColor {UIColor(hex: 0x4CE126)}
    class var coGreen: UIColor {UIColor(hex: 0x058954)}
    
    class var backGround1: UIColor {UIColor(hex: 0x99F2F8F7)}
    class var backGround2: UIColor {UIColor(hex: 0xFFFFFF)}
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
}
