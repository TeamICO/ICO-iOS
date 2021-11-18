//
//  SearchResultResponse.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/18.
//

import Foundation

// MARK: - SearchResultResponse
struct SearchResultResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: SearchResultResult
}

// MARK: - Result
struct SearchResultResult: Codable {
    let resultCnt: Int
    let seachResult: [SeachResultData]
}

// MARK: - SeachResult
struct SeachResultData: Codable {
    let styleshotIdx: Int
    let imageURL: String
    let profileURL: String
    let nickname: String
    let category: [String]
    let isLike: Int

    enum CodingKeys: String, CodingKey {
        case styleshotIdx
        case imageURL = "imageUrl"
        case profileURL = "profileUrl"
        case nickname, category, isLike
    }
}
