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
    var isPopularPaginating = false
    var isIcoStylePaginating = false
    var isKeywordPaginating = false
    
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
    //인기있는 아이코 상단 부분
    func getPopularIcoUser(_ viewcontroller: PopularIcoVC,userIdx: Int){
        AF.request("https://prod.chuckwagon.shop/app/users/\(userIdx)/mystyle",method: .get, parameters: nil, headers: Constant.HEADER)
            .validate()
            .responseDecodable(of: MyStyleUser.self){ response in
                switch response.result{
                case .success(let response):
                    viewcontroller.serverData = response.result
                    viewcontroller.didSuccessGetPopularIcoUser(message: response.message)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }

            }
    }
    //인기 있는 아이코 스타일샷 부분
    func getPopularIcoStyleShot(pagination: Bool = false, lastIndex: Int,userIdx:Int, _ viewcontroller: PopularIcoVC, completion: @escaping( [StyleShotResult]?) -> Void){
        if pagination{
            isIcoStylePaginating = true
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
                        self.isIcoStylePaginating = false
                    }
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            }
    }
    //라이프스타일 카테고리 최근
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
    //라이프스타일 카테고리 인기
    func getPopularInfo(pagination: Bool = false, lastIndex: Int, _ viewcontroller: PopularVC , completion: @escaping([RecentResult]?) -> Void){
        if pagination{
            isPopularPaginating = true
        }
        
        let param = [
            "filter" : "2",
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
                        self.isPopularPaginating = false
                    }
                   
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
 
            }
    }

    //라이프스타일 카테고리 키워드
    func getKeywordInfo(pagination: Bool = false, lastIndex: Int,_ viewcontroller: KeywordVC,_ categoryIdx: String, completion: @escaping([RecentResult]?) -> Void){
        
        if pagination{
            isKeywordPaginating = true
        }
        
        let url = "\(Constant.BASE_URL)/app/styleshots/lifestyle?"
        
        var param = [
            "filter" : "3",
            "categoryIdx" : categoryIdx,
            "no": "\(lastIndex)"
        ]
        
       
        AF.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: Constant.HEADER)
            .validate()
            .responseDecodable(of: StyleLifeRecent.self){ response in
                switch response.result{
                    case .success(let response):
                        guard response.isSuccess == true else{
                            return
                        }
                        completion(response.result)
                        if pagination{
                            self.isKeywordPaginating = false
                        }
                    
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }

    }
}
