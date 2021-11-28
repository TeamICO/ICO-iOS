//
//  StyleLifeDataManager.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/16.
//

import Foundation
import Alamofire
import SwiftUI

class StyleLifeDataManager{
    static let shared = StyleLifeDataManager()
    var isRecentPaginating = false
    
    func getStyleLifeTop(_ viewcontroller: PopularVC){
        
        AF.request("\(Constant.BASE_URL)/app/lifestyle/popular", method: .get, parameters: nil, headers: Constant.HEADER)
            .validate()
            .responseDecodable(of: StyleLifeResponse.self){ response in
                switch response.result{
                case .success(let response):
                    viewcontroller.serverData = response.result
                    viewcontroller.didSuccessGetTop(message: response.message)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
  
            }
    }
    
    func getPopularIcoInfo(_ viewcontroller: PopularIcoVC, userIdx: Int){
        
        AF.request("\(Constant.BASE_URL)/app/users/\(userIdx)/styleshots",method: .get, parameters: nil, headers: Constant.HEADER)
            .validate()
            .responseDecodable(of: MyStyleResponse.self){ response in
                switch response.result{
                    case .success(let response):
                        viewcontroller.serverData = response.result
                        viewcontroller.didSuccessGetPopularIco(message: response.message)
                    
                     case .failure(let error):
                        print(error.localizedDescription)
                }
            }
    }
    
    func getRecentInfo(pagination: Bool = false, lastIndex: Int, _ viewcontroller: RecentVC , completion: @escaping([RecentResult]?) -> Void){
        if pagination{
            isRecentPaginating = true
        }
        
        let param = [
            "filter" : "1",
            "no": "\(lastIndex)"
        ]
    
        AF.request("https://prod.chuckwagon.shop/app/styleshots/lifestyle?",method: .get,parameters: param,encoding: URLEncoding.default, headers: Constant.HEADER)
            .validate()
            .responseDecodable(of: StyleLifeRecent.self){ response in
                switch response.result{
                case .success(let response):
                    guard response.isSuccess == true else{
                        return
                    }
                    completion(response.result)
                    if pagination{
                        self.isRecentPaginating = false
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
 
            }
    }
    
    func getPopularInfo(_ viewcontroller: PopularVC){
        AF.request("https://dev.chuckwagon.shop/app/styleshots/lifestyle?filter=2",method: .get, parameters: nil,headers: Constant.HEADER)
            .validate()
            .responseDecodable(of: StyleLifeRecent.self){ response in
                switch response.result{
                    case .success(let response):
                        viewcontroller.popularServerData = response.result
                        viewcontroller.didSuccessGetPopularInfo(message: response.message)
                
                    case .failure(let error):
                        print(error.localizedDescription)
                    
                }
            }
    }
    
    func getKeywordInfo(_ viewcontroller: KeywordVC,_ categoryIdx: Int){
        let url = "\(Constant.BASE_URL)/app/styleshots/lifestyle?"
        
        var param = [
            "filter" : 3,
            //"categoryIdx[]" : categoryIdx
        ]
        param.updateValue(categoryIdx, forKey: "categoryIdx[]")
        
       
        AF.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: Constant.HEADER)
            .validate()
            .responseDecodable(of: StyleLifeRecent.self){ response in
                switch response.result{
                    case .success(let response):
                        viewcontroller.keywordServerData = response.result
                        viewcontroller.didSuccessGetKeyword(message: response.message)
                        print(param)
                    
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }

    }
}
