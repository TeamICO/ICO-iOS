//
//  LikeResponse.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/18.
//

import Foundation
// MARK: - LikeResponse
struct LikeResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [LikeResult]?
}

// MARK: - Result
struct LikeResult: Codable {
    let no : Int?
    let styleshotIdx: Int
    let imageURL, profileURL: String
    let nickname: String
    let category: [String]
    let isLike: Int

    enum CodingKeys: String, CodingKey {
        case no
        case styleshotIdx
        case imageURL = "imageUrl"
        case profileURL = "profileUrl"
        case nickname, category, isLike
    }
}

