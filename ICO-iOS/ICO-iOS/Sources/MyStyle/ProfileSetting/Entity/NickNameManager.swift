//
//  NicNameManager.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/17.
//

import Foundation
import Alamofire
final class NickNameManager{
    static let shared = NickNameManager()
    private init() {}
    
    
    func checkNickName(nickname: String,jwtToken: String, completion: @escaping (CommonResponse)->Void) {

        let url = "https://dev.chuckwagon.shop/app/users?"
        


        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : jwtToken
        ]
        let param = [
            "nickname" : nickname
        ]

        AF.request(url,
                   method: .get,
                   parameters: param,
                   encoding: URLEncoding.default,
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
