//
//  StyleReportRequest.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/20.
//

import Foundation

struct StyleReportRequest: Codable {
    let reason: String
    let styleshotIdx: Int
}

struct StyleDeleteRequest: Codable {
    let status: String
}
