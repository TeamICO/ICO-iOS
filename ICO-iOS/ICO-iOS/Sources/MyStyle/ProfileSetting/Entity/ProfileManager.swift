//
//  ProfileManager.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/16.
//

import Foundation
import Alamofire
final class ProfileManager{
    static let shared = ProfileManager()
    private init() {}
    
    
    func getUserProfile(userIdx: Int,jwtToken: String, completion: @escaping (ProfileResult?)->Void) {

        let url = "https://dev.chuckwagon.shop/app/users/\(userIdx)"

   
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : jwtToken
        ]


        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: header)
            .responseDecodable(of: ProfileResponse.self) { response in
                
                switch response.result {
                
                case .success(let response):
                    guard response.isSuccess else{
                        return
                    }
    
                    completion(response.result)
                    
                    
                    
                case .failure(let error):
                    print("DEBUG>> getUserProfile Get Error : \(error.localizedDescription)")
                    
                }
            }
        
    }
}

