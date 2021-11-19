//
//  KakaoLoginResponse.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/16.
//

import Foundation
struct LoginResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: LoginResult
}

// MARK: - Result
struct LoginResult: Codable {
    let userIdx: Int
    let jwt: String
    let nickname : String
}
