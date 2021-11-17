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
    
    
    func updateUserProfile(imageData : UIImage?, nickname: String,description: String,activatedEcoKeyword: [String],userIdx: Int,jwtToken: String, completion: @escaping (CommonResponse)->Void) {
        let url = "https://dev.chuckwagon.shop/app/users/\(userIdx)"
        
        let header : HTTPHeaders = [
            "Content-Type" : "multipart/form-data",
            "X-ACCESS-TOKEN" : jwtToken
        ]
        let parameters: [String : Any] = [
            "nickname": nickname,
            "description": description,
            "activatedEcoKeyword" : activatedEcoKeyword,
            "marketingAgree": "Y",
            "styleAgree": "Y"
        ]
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if key == "activatedEcoKeyword"{
                    for idx in value as! [String] {
                        multipartFormData.append("\(idx)".data(using: .utf8, allowLossyConversion: false)!, withName: "activatedEcoKeyword")
                    }
                }else{
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }
                
            }

            if let image = imageData?.pngData() {
                multipartFormData.append(image, withName: "image", fileName: "\(image).png", mimeType: "image/png")
            }
        }, to: url, usingThreshold: UInt64.init(),
                  method: .patch,
                  headers: header)
            .responseDecodable(of: CommonResponse.self) { response in
                
                switch response.result {
                
                case .success(let response):

                    completion(response)

                case .failure(let error):
                    print("DEBUG>> checkNicName Get Error : \(error.localizedDescription)")
                    
                }
            }
    }
}
