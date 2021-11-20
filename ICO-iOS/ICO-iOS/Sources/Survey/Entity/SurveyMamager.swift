//
//  SurveyMamager.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/20.
//

import Foundation
import Alamofire
final class SurveyMamager{
    static let shared = SurveyMamager()
    private init() {}
    
    
    func insertUserSurveyInfo(activatedEcoKeyword: [String],userIdx: Int,jwtToken: String, completion: @escaping (CommonResponse)->Void) {
        let url = "https://dev.chuckwagon.shop/app/users/\(userIdx)"
        
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : jwtToken
        ]
        let parameters: [String : Any] = [
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
