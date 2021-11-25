//
//  SearchResultManager.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/18.
//

import Foundation
import Alamofire
final class SearchResultManager{
    static let shared = SearchResultManager()
    private init() {}
    var isPaginating = false
    
    func getSearchResult(keyword : String,filter : String,jwtToken: String, completion: @escaping (SearchResultResult?)->Void) {

        let url = "https://dev.chuckwagon.shop/app/styleshots/search?"
        
   
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : jwtToken
        ]
        let param = [
            "keyword" : keyword,
            "filter" : filter
        ]

        AF.request(url,
                   method: .get,
                   parameters: param,
                   encoding: URLEncoding.default,
                   headers: header)
            .responseDecodable(of: SearchResultResponse.self) { response in
                
                switch response.result {
                
                case .success(let response):

                    guard response.isSuccess else{
                        return
                    }
                    completion(response.result)
                    
                case .failure(let error):
                    print("DEBUG>> getSearchResult Get Error : \(error.localizedDescription)")
                    
                }
            }
        
    }
    
    func getMoreSearchResult(pagination : Bool = false,lastIndex : Int,filter: String,keyword : String, jwtToken: String, completion: @escaping ([SeachResultData]?)->Void) {
      
        if pagination {
            isPaginating = true
        }
        let url = "https://prod.chuckwagon.shop/app/styleshots/search?"

     
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : jwtToken
        ]
        let param = [
            "keyword" : keyword,
            "filter" : filter,
            "no" : "\(lastIndex)"
        ]
        DispatchQueue.global().asyncAfter(deadline: .now(),execute: {
            AF.request(url,
                       method: .get,
                       parameters: param,
                       encoding: URLEncoding.default,
                       headers: header)
                .responseDecodable(of: SearchResultResponse.self) { response in
                    
                    switch response.result {
        
                    case .success(let response):
                        
                        guard response.isSuccess == true else{
                            return
                        }
                        
                        completion(response.result.seachResult)
                        if pagination {
                            self.isPaginating = false
                        }
                    case .failure(let error):
                        print("DEBUG>> getMoreSearchResult Get Error : \(error.localizedDescription)")
                        
                    }
                }
        })

        
    }
}
