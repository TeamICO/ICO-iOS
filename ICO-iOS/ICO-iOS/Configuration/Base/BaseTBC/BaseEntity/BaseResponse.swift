//
//  BaesResponse.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/17.
//

import Foundation
// MARK: - Welcome
struct BaseResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: BaseResult
}

// MARK: - Result
struct BaseResult: Codable {
    let userIdx: Int
}
