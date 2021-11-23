//
//  FeedbackManager.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/16.
//

import Foundation
import Alamofire
final class FeedbackManager{
    static let shared = FeedbackManager()
    private init() {}
    
    
    func sendFeedback(jwtToken : String,feedbackText : String, completion: @escaping (Bool)->Void) {

        let url = "https://dev.chuckwagon.shop/app/feedback"

   
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : jwtToken
        ]
        let param = [
            "feedback" : feedbackText
        ]

        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: header)
            .responseDecodable(of: FeedbackResponse.self) { response in
                
                switch response.result {
                
                case .success(let response):
                    completion(response.isSuccess)
            
                case .failure(let error):
                    print("DEBUG>> getHomeData Get Error : \(error.localizedDescription)")
                    
                }
            }
        
    }
}
