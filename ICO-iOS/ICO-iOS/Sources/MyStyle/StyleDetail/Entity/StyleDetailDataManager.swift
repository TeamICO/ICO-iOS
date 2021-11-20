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
        AF.request("\(Constant.BASE_URL)/app/styleshots/\(styleShotIdx)", method: .get, parameters: nil,headers: Constant.header)
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
    
    func reportStyleDetail(_ parameters: StyleReportRequest,_ viewcontroller: StyleDetailVC){
        AF.request("\(Constant.BASE_URL)/app/reports",method: .post, parameters: parameters, headers: Constant.header)
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
}
