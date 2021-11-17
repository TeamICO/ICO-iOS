//
//  SearchResponse.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/17.
//

import Foundation
// MARK: - Welcome
struct SearchResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: SearchResult
}

// MARK: - Result
struct SearchResult: Codable {
    let topKeyword: [String]?
    let keywordHistory: [KeywordHistory]
    let bannerImageURL: String

    enum CodingKeys: String, CodingKey {
        case topKeyword, keywordHistory
        case bannerImageURL = "bannerImageUrl"
    }
}

// MARK: - KeywordHistory
struct KeywordHistory: Codable {
    let keyword: String
    let keywordIdx: Int
}
