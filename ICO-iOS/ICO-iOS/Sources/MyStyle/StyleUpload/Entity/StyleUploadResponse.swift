//
//  StyleUploadResponse.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/22.
//

import Foundation


// MARK: - StyleUploadResponse
struct StyleUploadResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: UploadResult?
}

// MARK: - UploadResult
struct UploadResult: Codable {
    let styleshotIdx, levelUp: Int
}


struct StyleEditResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: StyleEditResult
}

// MARK: - StyleEditResult
struct StyleEditResult: Codable {
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
 
