//
//  MyStyleDataManager.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/17.
//

import Foundation
import Alamofire

class MyStyleDataManager{
    static let shared = MyStyleDataManager()
    var isStyleShotPaginating = false
    
    func getMyStyleUser(_ viewcontroller: MyStyleVC, userIdx: Int){
        AF.request("\(Constant.BASE_URL)/app/users/\(userIdx)/mystyle",method: .get, parameters: nil, headers: Constant.HEADER)
            .validate()
            .responseDecodable(of: MyStyleUser.self){ response in
                switch response.result{
                case .success(let response):
                    viewcontroller.serverData = response.result
                    viewcontroller.didSuccessGetMyStyleUser(message: response.message)
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)

                }
            }
    }
    
    
    func getMyStyleShot(pagination: Bool = false, lastIndex: Int,userIdx:Int, _ viewcontroller: MyStyleVC, completion: @escaping( [StyleShotResult]?) -> Void){
        if pagination{
            isStyleShotPaginating = true
        }
        
        let param = [
            "no" :  "\(lastIndex)"
        ]
        
        AF.request("https://prod.chuckwagon.shop/app/users/\(userIdx)/styleshots?",method: .get,parameters: param, encoding: URLEncoding.default, headers: Constant.HEADER)
            .responseDecodable(of: MyStyleShot.self){ response in
                switch response.result{
                case .success(let response):
                    guard response.isSuccess == true else{
                        return
                    }
                    
                    completion(response.result)
                    if pagination{
                        self.isStyleShotPaginating = false
                    }
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            }
        
        
    }
 

}
