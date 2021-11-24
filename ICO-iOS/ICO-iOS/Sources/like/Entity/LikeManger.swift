//
//  LikeManger.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/18.
//

import Foundation
import Alamofire
final class LikeManger{
    static let shared = LikeManger()
    private init() {}
    var isLikePaginating = false
    
    func getUserLikes(jwtToken: String, completion: @escaping ([LikeResult]?)->Void) {

        let url = "https://dev.chuckwagon.shop/app/likes"

   
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : jwtToken
        ]


        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: header)
            .responseDecodable(of: LikeResponse.self) { response in
                
                switch response.result {
                
                case .success(let response):
                    guard response.isSuccess == true else{
                        return
                    }
                    
                    completion(response.result)
                    
                    
                    
                case .failure(let error):
                    print("DEBUG>> getUserLikes Get Error : \(error.localizedDescription)")
                    
                }
            }
        
    }
    
    
    
    func getMoreLikes(pagination : Bool = false,lastIndex : Int, jwtToken: String, completion: @escaping ([LikeResult]?)->Void) {
        if pagination {
            isLikePaginating = true
        }
        let url = "https://prod.chuckwagon.shop/app/likes?"

   
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : jwtToken
        ]
        let param = [
            "no" : "\(lastIndex)"
        ]
        DispatchQueue.global().asyncAfter(deadline: .now() + 1,execute: {
            AF.request(url,
                       method: .get,
                       parameters: param,
                       encoding: URLEncoding.default,
                       headers: header)
                .responseDecodable(of: LikeResponse.self) { response in
                    
                    switch response.result {
                    
                    case .success(let response):
                        guard response.isSuccess == true else{
                            return
                        }
                        
                        completion(response.result)
                        if pagination {
                            self.isLikePaginating = false
                        }
                    case .failure(let error):
                        print("DEBUG>> getMoreLikes Get Error : \(error.localizedDescription)")
                        
                    }
                }
        })

        
    }
}
