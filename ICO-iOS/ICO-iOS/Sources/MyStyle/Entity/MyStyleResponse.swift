//
//  MyStyleResponse.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/17.
//

import Foundation

// MARK: - MyStyleUser
struct MyStyleUser: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: UserInfoResult
}

// MARK: - UserInfoResult
struct UserInfoResult: Codable {
    let nickname, profileURL, resultDescription: String
    let styleshotCnt, likeCnt, isMe: Int
    let ecoKeyword: [String]

    enum CodingKeys: String, CodingKey {
        case nickname
        case profileURL = "profileUrl"
        case resultDescription = "description"
        case styleshotCnt, likeCnt, isMe, ecoKeyword
    }
}

// MARK: - MyStyleShot
struct MyStyleShot: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [StyleShotResult]
}

// MARK: - StyleShotResult
struct StyleShotResult: Codable {
    let no, styleshotIdx: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case no, styleshotIdx
        case imageURL = "imageUrl"
    }
}

