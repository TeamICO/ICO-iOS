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
    
    
    func sendFeedback(feedbackText : String, completion: @escaping (Bool)->Void) {

        let url = "https://dev.chuckwagon.shop/app/feedback"

   
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoyLCJpYXQiOjE2MzYzODYwMDQsImV4cCI6MTY2NzkyMjAwNCwic3ViIjoidXNlckluZm8ifQ.0MwJnTpc2qf5ixJZ6MQPIE_gGqHGuMv-HAbD336-Ba4"
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
