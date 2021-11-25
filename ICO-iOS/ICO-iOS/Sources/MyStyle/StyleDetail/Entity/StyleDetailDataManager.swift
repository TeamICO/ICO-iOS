//
//  StyleDetailDataManager.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/20.
//

import Foundation
import Alamofire

class StyleDetailDataManager{
    func getStyleDetail(_ viewcontroller: StyleDetailVC, styleShotIdx: Int){
        AF.request("\(Constant.BASE_URL)/app/styleshots/\(styleShotIdx)", method: .get, parameters: nil,headers: Constant.HEADER)
            .validate()
            .responseDecodable(of:StyleDetailResponse.self){ response in
                switch response.result{
                case .success(let response):
                    viewcontroller.StyleDetailData = response.result
                    viewcontroller.didSuccessStyleDetail(message: response.message)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    func getStyleDetail(styleShotIdx: Int,completion : @escaping (StyleDetailResult?)->Void){
        AF.request("\(Constant.BASE_URL)/app/styleshots/\(styleShotIdx)", method: .get, parameters: nil,headers: Constant.HEADER)
            .validate()
            .responseDecodable(of:StyleDetailResponse.self){ response in
                switch response.result{
                case .success(let response):
                 
                    guard response.isSuccess else{
                        return
                    }
                    completion(response.result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func reportStyleDetail(_ parameters: StyleReportRequest,_ viewcontroller: StyleDetailVC){
        AF.request("\(Constant.BASE_URL)/app/reports",method: .post, parameters: parameters, headers: Constant.HEADER)
            .validate()
            .responseDecodable(of: StyleReportResponse.self){ response in
                switch response.result{
                    case .success(let response):
                        viewcontroller.didSuccessReport(message: response.message)
                    case .failure(let error):
                        print(error.localizedDescription)
                }
                
            }
    }
    
    func deleteStyleDetail(_ parameters: StyleDeleteRequest, _ viewcontroller: StyleDetailVC, styleshotIdx: Int){
        AF.request("\(Constant.BASE_URL)/app/styleshots/\(styleshotIdx)",method: .patch,parameters: parameters,headers: Constant.HEADER)
            .validate()
            .responseDecodable(of: StyleChangeResponse.self){ response in
                switch response.result{
                case .success(let response):
                    viewcontroller.didSuccessDelete(message: response.message)
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
    }
    
    func likeStyle(_ styleIdx: Int,completion : @escaping(Bool)->Void){
        let param = [
            "styleshotIdx" : styleIdx
        ]
        AF.request("\(Constant.BASE_URL)/app/likes", method: .post, parameters: param, headers: Constant.HEADER)
            .validate()
            .responseDecodable(of: LikeResponse.self){ response in
                switch response.result{
                case .success(let response):
                    guard response.isSuccess else{
                        return
                    }
                    completion(true)
                case .failure(let error):
                    print(error.localizedDescription)
                }

            }
    }
    
    func disLikeStyle(_ paramter: disLikeRequest, styleshotIdx:Int,completion : @escaping(Bool)->Void){
        AF.request("\(Constant.BASE_URL)/app/likes/\(styleshotIdx)",method: .patch,parameters: paramter,headers: Constant.HEADER)
            .validate()
            .responseDecodable(of: StyleChangeResponse.self){ response in
                switch response.result{
                case .success(let response):
                    guard response.isSuccess else{
                        return
                    }
                    completion(true)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
