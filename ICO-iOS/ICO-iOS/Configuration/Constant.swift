//
//  Constant.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//

import Foundation
import Alamofire

struct Constant {
    static let BASE_URL = "https://dev.chuckwagon.shop"
    static var HEADER: HTTPHeaders = ["X-ACCESS-TOKEN" : UserDefaults.standard.value(forKey: "jwtToken") as! String]
    
}
