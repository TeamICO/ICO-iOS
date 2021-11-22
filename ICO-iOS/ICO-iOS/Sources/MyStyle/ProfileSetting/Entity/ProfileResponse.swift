//
//  ProfileResponse.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/16.
//

import Foundation

// MARK: - Welcome
struct ProfileResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: ProfileResult
}

// MARK: - Result
struct ProfileResult: Codable {
    let profileURL: String?
    let nickname : String
    let resultDescription: String?
    let ecoKeyword: [ProfileEcoKeyword]

    enum CodingKeys: String, CodingKey {
        case profileURL = "profileUrl"
        case nickname
        case resultDescription = "description"
        case ecoKeyword
    }
}

// MARK: - EcoKeyword
struct ProfileEcoKeyword: Codable {
    let ecoKeywordIdx: Int
    let name, type: String
    let status: EcoStatus
}

enum EcoStatus: String, Codable {
    case n = "N"
    case y = "Y"
}
