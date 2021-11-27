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
    
    func getRecentInfo(_ viewcontroller: RecentVC){
        
        AF.request("https://dev.chuckwagon.shop/app/styleshots/lifestyle?filter=1",method: .get,parameters: nil,headers: Constant.HEADER)
            .validate()
            .responseDecodable(of: StyleLifeRecent.self){ response in
                switch response.result{
                case .success(let response):
                    viewcontroller.serverData = response.result
                    viewcontroller.didSuccessGetRecentInfo(message: response.message)
                    
                    
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
        
        let param = [
            "filter" : 3,
            "categoryIdx[]" : categoryIdx
        ]
       
        AF.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: Constant.HEADER)
            .validate()
            .responseDecodable(of: StyleLifeRecent.self){ response in
                switch response.result{
                    case .success(let response):
                        viewcontroller.keywordServerData = response.result
                        viewcontroller.didSuccessGetKeyword(message: response.message)
                    
                    
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }

    }
}
