//
//  UIView.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//

import Foundation
import UIKit
extension UIView {
    
    public var width: CGFloat {
        return self.frame.size.width
    }
    public var height: CGFloat {
        return self.frame.size.height
    }
    public var top: CGFloat {
        return self.frame.origin.y
    }
    public var bottom: CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }
    public var left: CGFloat {
        return self.frame.origin.x
    }
    public var right: CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }
    // 뷰 그라데이션
    func setGradient(color1 : UIColor, color2 : UIColor){
        let gradient : CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.7, y: 0.0)
        gradient.frame = self.bounds
        self.layer.addSublayer(gradient)
        
    }
    func setVerticalGradient(color1 : UIColor, color2 : UIColor){
        let gradient : CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.4)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}
@IBDesignable extension UIView {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius 
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    func addGradientBackground(firstColor: UIColor, secondColor: UIColor){
             clipsToBounds = true
             let gradientLayer = CAGradientLayer()
             gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
             gradientLayer.frame = self.bounds
             gradientLayer.startPoint = CGPoint(x: 0, y: 0)
             gradientLayer.endPoint = CGPoint(x: 0, y: 1)
             self.layer.insertSublayer(gradientLayer, at: 0)
         }
    
}

