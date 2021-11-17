//
//  MyStyleDataManager.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/17.
//

import Foundation
import Alamofire

class MyStyleDataManager{
    func getMyStyleInfo(_ viewcontroller: MyStyleVC, userIdx: Int){
        
        AF.request("\(Constant.BASE_URL)/app/users/\(userIdx)/styleshots",method: .get, parameters: nil, headers: Constant.header)
            .validate()
            .responseDecodable(of: MyStyleResponse.self){ response in
                switch response.result{
                    case .success(let response):
                        viewcontroller.serverData = response.result
                        viewcontroller.didSuccessGetMyStyle(message: response.message)
                    
                     case .failure(let error):
                        print(error.localizedDescription)
                }
            }
    }

}
