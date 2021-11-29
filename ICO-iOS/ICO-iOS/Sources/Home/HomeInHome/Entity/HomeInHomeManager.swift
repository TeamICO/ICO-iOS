//
//  HomeInHomeManager.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/16.
//

import Foundation
import Alamofire
final class HomeInHomeManager{
    static let shared = HomeInHomeManager()
    private init() {}
    
    
    func getHomeInHomeData(jwtToken: String, completion: @escaping (HomeInHomeResult)->Void) {

        let url = "https://prod.chuckwagon.shop/app/home"

   
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : jwtToken
        ]


        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: header)
            .responseDecodable(of: HomeInHomeResponse.self) { response in
                
                switch response.result {
                
                case .success(let response):
    
                    guard response.isSuccess == true else{
                        return
                    }
                    
                    completion(response.result)
                    
                    
                    
                case .failure(let error):
                    print("DEBUG>> getHomeData Get Error : \(error.localizedDescription)")
                    
                }
            }
        
    }
}

