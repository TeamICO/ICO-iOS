//
//  BasePageControl.swift
//  ICO
//
//  Created by do_yun on 2021/11/05.
//

import UIKit

class BasePageControl: UIPageControl {

    override var currentPage: Int {
          didSet {
              updateDots()
          }
      }

      func updateDots() {
          let currentDot = subviews[currentPage]

          let spacing = 5.0

          subviews.forEach {
//              $0.frame = ($0 == currentDot) ? CGRect(x: 0, y: 0, width: 16, height: 4) : CGRect(x: spacing, y: 0, width: 8, height: 4)
              $0.frame = CGRect(x: 0, y: 0, width: 15, height: 5)
              $0.layer.cornerRadius = 2
          }
      }

}
