//
//  StyleUploadRequest.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/22.
//

import Foundation

struct StyleUploadRequest: Codable {
    let image: String
    let category: [Int]
    let productName: String
    let productURL: String
    let point: Int
    let purpleDescription: String
    let hashtag: [String]

    enum CodingKeys: String, CodingKey {
        case image, category, productName
        case productURL = "productUrl"
        case point
        case purpleDescription = "description"
        case hashtag
    }
}
