//
//  MyStyleResponse.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/17.
//

import Foundation

// MARK: - MyStyleResponse
struct MyStyleResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: MyStyleResult
}

// MARK: - Result
struct MyStyleResult: Codable {
    let nickname: String
    let profileURL: String
    let resultDescription: String
    let styleshotCnt, likeCnt, isMe: Int
    let ecoKeyword: [String]
    let styleshot: [Styleshot]

    enum CodingKeys: String, CodingKey {
        case nickname
        case profileURL = "profileUrl"
        case resultDescription = "description"
        case styleshotCnt, likeCnt, isMe, ecoKeyword, styleshot
    }
}

// MARK: - Styleshot
struct Styleshot: Codable {
    let styleshotIdx: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case styleshotIdx
        case imageURL = "imageUrl"
    }
}
