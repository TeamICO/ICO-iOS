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
    
    
    func updateUserProfile(imageData : String?, nickname: String,description: String,activatedEcoKeyword: [String],userIdx: Int,jwtToken: String, completion: @escaping (CommonResponse)->Void) {
        let url = "https://prod.chuckwagon.shop/app/users/\(userIdx)"
        
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : jwtToken
        ]
        let parameters: [String : Any] = [
            "image" : imageData ?? "",
            "nickname": nickname,
            "description": description,
            "activatedEcoKeyword" : activatedEcoKeyword,
            "marketingAgree": "Y",
            "styleAgree": "Y"
        ]
   
        AF.request(url,
                   method: .patch,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
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
