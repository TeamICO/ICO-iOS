//
//  AlarmManager.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/18.
//

import Foundation
import Alamofire
final class AlarmManager{
    static let shared = AlarmManager()
    private init() {}
    
  
    func getUserAlarms(jwtToken: String, completion: @escaping (AlarmResult)->Void) {

        let url = "https://prod.chuckwagon.shop/app/notifications"

   
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : jwtToken
        ]


        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: header)
            .responseDecodable(of: AlarmResponse.self) { response in
                
                switch response.result {
                
                case .success(let response):
       
                    guard response.isSuccess == true else{
                        return
                    }
                    
                    completion(response.result)
                    
                    
                    
                case .failure(let error):
                    print("DEBUG>> getUserAlarms Get Error : \(error.localizedDescription)")
                    
                }
            }
        
    }
    func readAlarm(type: String,notificationIdx : Int,jwtToken: String, completion: @escaping (Bool)->Void) {
  
        let url = "https://prod.chuckwagon.shop/app/notifications/\(notificationIdx)"

        
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : jwtToken
        ]
        let param  = [
            "isNew" : "N",
            "type" : type
        ]

        AF.request(url,
                   method: .patch,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: header)
            .responseDecodable(of: CommonResponse.self) { response in
                
                switch response.result {
                
                case .success(let response):

                    completion(response.isSuccess)
                    
                    
                    
                case .failure(let error):
                    print("DEBUG>> readAlarm Get Error : \(error.localizedDescription)")
                    
                }
            }
        
    }
}
