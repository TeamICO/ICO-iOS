//
//  StyleUploadDataManager.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/22.
//

import Foundation
import Alamofire

class StyleUploadDataManager{
    func styleUpload(_ paramters: StyleUploadRequest,_ viewcontroller: StyleUploadVC){
        AF.request("\(Constant.BASE_URL)/app/styleshots",method: .post, parameters: paramters, headers: Constant.HEADER)
            .validate()
            .responseDecodable(of: StyleUploadResponse.self){ response in
                switch response.result{
                    case .success(let response):
                       viewcontroller.didSuccessStyleUpload(message: response.message,code: response.code)

                    case .failure(let error):
                        print(error.localizedDescription)
                       
                
                }
            }
        
    }
}