//
//  Constant.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//

import Foundation
import Alamofire

struct Constant {
    static let BASE_URL = "https://prod.chuckwagon.shop"
    static var HEADER: HTTPHeaders = ["X-ACCESS-TOKEN" : UserDefaults.standard.value(forKey: "jwtToken") as! String]
    static let VER = "1.0.5 최신Ver."
}
