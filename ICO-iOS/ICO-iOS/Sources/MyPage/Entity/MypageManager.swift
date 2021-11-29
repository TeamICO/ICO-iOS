//
//  MypageManager.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/16.
//

import Foundation
import Alamofire
final class MypageManager{
    static let shared = MypageManager()
    private init() {}
    
    
    func getMypageData(jwtToken: String, completion: @escaping (MypageResult?)->Void) {

        let url = "https://prod.chuckwagon.shop/app/mypage"

   
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : jwtToken
        ]


        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: header)
            .responseDecodable(of: MypageResponse.self) { response in
                
                switch response.result {
                
                case .success(let response):
                    guard response.isSuccess == true else{
                        return
                    }
                    
                    completion(response.result)
                    
                    
                    
                case .failure(let error):
                    print("DEBUG>> getMypage Get Error : \(error.localizedDescription)")
                    
                }
            }
        
    }
}
