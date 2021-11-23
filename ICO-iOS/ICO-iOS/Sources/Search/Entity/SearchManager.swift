//
//  SearchWordManager.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/17.
//

import Foundation
import Alamofire
final class SearchManager{
    static let shared = SearchManager()
    private init() {}
    
    
    func getSearchKeywordHistory(jwtToken: String, completion: @escaping (SearchResult?)->Void) {

        let url = "https://dev.chuckwagon.shop/app/keywords"

   
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : jwtToken
        ]


        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: header)
            .responseDecodable(of: SearchResponse.self) { response in
                
                switch response.result {
                
                case .success(let response):
                    guard response.isSuccess else{
                        return
                    }
                    completion(response.result)
                    
                case .failure(let error):
                    print("DEBUG>> getSearchKeywordHistory Get Error : \(error.localizedDescription)")
                    
                }
            }
        
    }
    
    func getKeywordHistory(jwtToken: String, completion: @escaping ([KeywordHistory]?)->Void) {

        let url = "https://dev.chuckwagon.shop/app/keywords"

   
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : jwtToken
        ]


        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: header)
            .responseDecodable(of: SearchResponse.self) { response in
                
                switch response.result {
                
                case .success(let response):
                    guard response.isSuccess else{
                        return
                    }
                    completion(response.result.keywordHistory)
                    
                case .failure(let error):
                    print("DEBUG>> getSearchKeywordHistory Get Error : \(error.localizedDescription)")
                    
                }
            }
        
    }
    
    func removeAllKeywordHistory(jwtToken: String, completion: @escaping (Bool)->Void) {

        let url = "https://dev.chuckwagon.shop/app/keywords"
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : jwtToken
        ]
        let param = [
            "status" : "N"
        ]

        AF.request(url,
                   method: .patch,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: header)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let response = value as! NSDictionary
                    let isSuccess = response.object(forKey: "isSuccess") as! Bool
                    completion(isSuccess)
                    
                case .failure(let error):
                    print("DEBUG>> getSearchKeywordHistory Get Error : \(error.localizedDescription)")
                    break
                }

                
            }
        
    }
    func removeKeywordHistory(keywordIdx: Int,jwtToken: String, completion: @escaping (Bool)->Void) {

        let url = "https://dev.chuckwagon.shop/app/keywords/\(keywordIdx)"
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : jwtToken
        ]
        let param = [
            "status" : "N"
        ]

        AF.request(url,
                   method: .patch,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: header)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let response = value as! NSDictionary
                    let isSuccess = response.object(forKey: "isSuccess") as! Bool
                    completion(isSuccess)
                    
                case .failure(let error):
                    print("DEBUG>> getSearchKeywordHistory Get Error : \(error.localizedDescription)")
                    break
                }

                
            }
        
    }
}
