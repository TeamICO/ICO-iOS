//
//  ProfileUpdateManager.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/17.
//

import Foundation
import Alamofire
final class ProfileUpdateManager{
    static let shared = ProfileUpdateManager()
    private init() {}
    
    
    func updateUserProfile(imageData : UIImage?, nickname: String,description: String,activatedEcoKeyword: [Int],userIdx: Int,jwtToken: String, completion: @escaping (CommonResponse)->Void) {
        let url = "https://dev.chuckwagon.shop/app/users/\(userIdx)"
        print(activatedEcoKeyword)
        let header : HTTPHeaders = [
            "Content-Type" : "multipart/form-data",
            "X-ACCESS-TOKEN" : jwtToken
        ]
        let parameters: [String : Any] = [
            "image": "image.png",
            "nickname": nickname,
            "description": description,
            "activatedEcoKeyword": activatedEcoKeyword,
            "marketingAgree": "Y",
            "styleAgree": "Y"
        ]
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
            if let image = imageData?.pngData() {
                multipartFormData.append(image, withName: "activityImage", fileName: "\(image).png", mimeType: "image/png")
            }
        }, to: url, usingThreshold: UInt64.init(), method: .patch, headers: header).responseJSON(completionHandler: { r in
            print(r)
        })
    }
}
