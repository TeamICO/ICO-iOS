//
//  AlarmResponse.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/18.
//

import Foundation
struct AlarmResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: AlarmResult
}

// MARK: - Result
struct AlarmResult: Codable {
    let today, previous: [Alarms]?
}

// MARK: - Previous
struct Alarms: Codable {
    let notificationIdx: Int
    let type: String
    let content: String?
    let description: String
    let isNew: Int
    let time: String

    enum CodingKeys: String, CodingKey {
        case notificationIdx, type, content
        case description
        case isNew, time
    }
}

struct AlarmViewModel : Codable{
    let type : String
    let content : String?
    let description : String
    let isNew : Int
    let time : String
    init(with model : Alarms){
        self.type = model.type
        self.content = model.content
        self.description = model.description
        self.isNew = model.isNew
        self.time = model.time
    }
}
