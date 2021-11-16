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
    
    
    func getHomeInHomeData( completion: @escaping (HomeInHomeResult)->Void) {

        let url = "https://dev.chuckwagon.shop/app/home"

   
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoyLCJpYXQiOjE2MzYzODYwMDQsImV4cCI6MTY2NzkyMjAwNCwic3ViIjoidXNlckluZm8ifQ.0MwJnTpc2qf5ixJZ6MQPIE_gGqHGuMv-HAbD336-Ba4"
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

