//
//  StyleLifeResponse.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/16.
//

import Foundation

// MARK: - StyleLifeResponse
struct StyleLifeResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result
}

// MARK: - Result
struct Result: Codable {
    let topBanner: TopBanner
    let popularIco: [PopularIco]
}

// MARK: - PopularIco
struct PopularIco: Codable {
    let userIdx: Int
    let profileURL: String
    let nickname, latestCategory: String

    enum CodingKeys: String, CodingKey {
        case userIdx
        case profileURL = "profileUrl"
        case nickname, latestCategory
    }
}

// MARK: - TopBanner
struct TopBanner: Codable {
    let imageURL: String
    let type, content: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case type, content
    }
}

// MARK: - Empty
struct StyleLifeRecent: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [RecentResult]
}

// MARK: - Result
struct RecentResult: Codable {
    let styleshotIdx: Int
    let imageURL: String
    let profileURL: String
    let nickname: Nickname
    let category: [String]
    let likeCnt: Int
    let productName, resultDescription: String
    let point: Int
    let time: String
    let isLike: Int

    enum CodingKeys: String, CodingKey {
        case styleshotIdx
        case imageURL = "imageUrl"
        case profileURL = "profileUrl"
        case nickname, category, likeCnt, productName
        case resultDescription = "description"
        case point, time, isLike
    }
}

enum Nickname: String, Codable {
    case 라일리 = "라일리"
    case 이안 = "이안"
    case 장영욱 = "장영욱"
}
