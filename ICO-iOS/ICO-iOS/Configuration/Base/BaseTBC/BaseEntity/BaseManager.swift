//
//  BaseManager.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/17.
//

import Foundation
import Alamofire
final class BaseManager{
    static let shared = BaseManager()
    private init() {}
    
    
    func getUserIdx(jwtToken: String, completion: @escaping (BaseResult)->Void) {

        let url = "https://dev.chuckwagon.shop/app/auto-login"

   
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : jwtToken
        ]


        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: header)
            .responseDecodable(of: BaseResponse.self) { response in
                
                switch response.result {
                
                case .success(let response):
                    guard response.isSuccess == true else{
                        return
                    }
                    
                    completion(response.result)
                    
                    
                    
                case .failure(let error):
                    print("DEBUG>> getUserIdx Get Error : \(error.localizedDescription)")
                    
                }
            }
        
    }
}


