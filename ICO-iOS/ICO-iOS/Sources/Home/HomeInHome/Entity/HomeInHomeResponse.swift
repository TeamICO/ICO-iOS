//
//  HomeInHomeResponse.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/16.
//

import Foundation
struct HomeInHomeResponse: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: HomeInHomeResult
}

// MARK: - HomeInHomeResult
struct HomeInHomeResult: Codable {
    let topBanner: [HomeInHomeTopBanner]?
    let keywordContents: [HomeInHomeKeywordContent]?
    let senseStyleshot: [HomeInHomeSenseStyleshot]?
    let popularStyleshot: [HomeInHomePopularStyleshot]?
    let bottomBanner: HomeInHomeBottomBanner?
    let brand: HomeInHomeBrand?
    let ecoTopic: HomeInHomeEcoTopic?
}

// MARK: - HomeInHomeBottomBanner
struct HomeInHomeBottomBanner: Codable {
    let imageURL: String
    let contentURL: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case contentURL = "contentUrl"
    }
}

// MARK: - HomeInHomeBrand
struct HomeInHomeBrand: Codable {
    let name: String
    let imageURL: String
    let contentURL: String
    let product: [HomeInHomeBrand]?

    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "imageUrl"
        case contentURL = "contentUrl"
        case product
    }
}

// MARK: - HomeInHomeEcoTopic
struct HomeInHomeEcoTopic: Codable {
    let name: String
    let imageURL: String
    let product: [HomeInHomeSenseStyleshot]

    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "imageUrl"
        case product
    }
}

// MARK: - SenseStyleshot
struct HomeInHomeSenseStyleshot: Codable {
    let styleshotIdx: Int
    let imageURL, profileURL: String
    let nickname: String
    let category: [String]

    enum CodingKeys: String, CodingKey {
        case styleshotIdx
        case imageURL = "imageUrl"
        case profileURL = "profileUrl"
        case nickname, category
    }
}

// MARK: - KeywordContent
struct HomeInHomeKeywordContent: Codable {
    let contentIdx: Int
    let title: String
}

// MARK: - PopularStyleshot
struct HomeInHomePopularStyleshot: Codable {
    let styleshotIdx: Int
    let imageURL: String
    let productName: String
    let point: Int
    let profileURL: String
    let nickname: String
    let category: [String]

    enum CodingKeys: String, CodingKey {
        case styleshotIdx
        case imageURL = "imageUrl"
        case productName, point
        case profileURL = "profileUrl"
        case nickname, category
    }
}

// MARK: - TopBanner
struct HomeInHomeTopBanner: Codable {
    let imageURL: String
    let type, content: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case type, content
    }
}
