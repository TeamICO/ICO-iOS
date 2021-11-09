//
//  UITextField.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//

import Foundation
import UIKit

// MARK: UITextField 글자 수 제한
private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        if let text = textField.text {
            textField.text = String(text.prefix(maxLength))
        }
    }
}
