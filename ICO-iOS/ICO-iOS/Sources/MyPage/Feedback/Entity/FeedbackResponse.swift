//
//  FeedbackResponse.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/16.
//

import Foundation
// MARK: - Welcome
struct FeedbackResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
