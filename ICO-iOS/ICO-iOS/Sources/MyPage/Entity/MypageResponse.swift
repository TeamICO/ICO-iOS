//
//  MypageResponse.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/16.
//

import Foundation

// MARK: - Welcome
struct MypageResponse: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: MypageResult
}

// MARK: - Result
struct MypageResult: Codable {
    let name, nickname: String?
    let profileURL: String?
    let level, tree, earth, together: Int
    let marketingAgree, styleshotAgree: Int
    let styleshot: [MyPageStyleshot]?

    enum CodingKeys: String, CodingKey {
        case name, nickname
        case profileURL = "profileUrl"
        case level, tree, earth, together, marketingAgree, styleshotAgree, styleshot
    }
}

// MARK: - Styleshot
struct MyPageStyleshot: Codable {
    let styleshotIdx: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case styleshotIdx
        case imageURL = "imageUrl"
    }
}
