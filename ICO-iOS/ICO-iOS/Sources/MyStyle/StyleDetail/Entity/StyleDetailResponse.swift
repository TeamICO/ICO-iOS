//
//  StyleDetailResponse.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/20.
//

import Foundation

struct StyleDetailResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: StyleDetailResult
}

// MARK: - StyleDetailResult
struct StyleDetailResult: Codable {
    let imageURL, profileURL: String
    let nickname: String
    let likeCnt, isLike: Int
    let category: [String]
    let productName: String
    let point: Int
    let resultDescription: String
    let hashtag: [String]
    let productURL: String
    let isMe: Int

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case profileURL = "profileUrl"
        case nickname, likeCnt, isLike, category, productName, point
        case resultDescription = "description"
        case hashtag
        case productURL = "productUrl"
        case isMe
    }
}

// MARK: - StyleChangeResponse
struct StyleChangeResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
