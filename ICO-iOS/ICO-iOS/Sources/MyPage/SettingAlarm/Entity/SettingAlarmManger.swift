//
//  SettingAlarmManger.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/30.
//

import Foundation
import Alamofire
final class SettingAlarmManger{
    static let shared = SettingAlarmManger()
    private init() {}
    
    
    func updateUserAlarm(marketingAgree : String?,styleAgree : String?,userIdx: Int,jwtToken: String) {
        let url = "https://prod.chuckwagon.shop/app/users/\(userIdx)"
        
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : jwtToken
        ]
        let parameters: [String : Any] = [
            "marketingAgree": marketingAgree ?? "",
            "styleAgree": styleAgree ?? ""
        ]
   
        AF.request(url,
                   method: .patch,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: header)
            .responseJSON { response in
            }
    }
}
