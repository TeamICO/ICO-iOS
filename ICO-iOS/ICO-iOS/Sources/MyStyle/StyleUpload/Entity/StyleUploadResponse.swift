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
    let styleshotIdx: Int
}
 
