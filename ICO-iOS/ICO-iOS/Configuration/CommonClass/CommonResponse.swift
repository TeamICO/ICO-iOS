//
//  CommonResponse.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/16.
//

import Foundation
struct CommonResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
