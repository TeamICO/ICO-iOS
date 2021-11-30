//
//  BaseManager.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/17.
//

import Foundation
import Alamofire
import FirebaseStorage

final class BaseManager{
    static let shared = BaseManager()
    
    private let container = Storage.storage()
    
    private init() {}
    
    
    func getUserIdx(jwtToken: String, completion: @escaping (BaseResult)->Void) {

        let url = "https://prod.chuckwagon.shop/app/auto-login"

        
   
        let header : HTTPHeaders = [
            "X-ACCESS-TOKEN" : jwtToken
        ]


        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: header)
            .responseDecodable(of: BaseResponse.self) { response in
                
                switch response.result {
                
                case .success(let response):
                    guard response.isSuccess == true else{
                        return
                    }
                    
                    completion(response.result)
                    
                    
                    
                case .failure(let error):
                    print("DEBUG>> getUserIdx Get Error : \(error.localizedDescription)")
                    
                }
            }
        
    }
    
    public func uploadImage(image: UIImage?,imageId : String,completion: @escaping(Bool)->Void){
        guard let pngData = image?.pngData() else{
            return
        }

        container
            .reference(withPath: "images/\(imageId)")
            .putData(pngData, metadata: nil) { metadata, error in
                guard metadata != nil, error == nil else{
                    print(error)
                    print("이미지 업로드 실패")
                    completion(false)
                    return
                }
                completion(true)
            }
    }

    public func downloadUrlForPostImage(imageId: String,completion: @escaping(URL?)->Void){
        container
            .reference(withPath: "images/\(imageId)")
            .downloadURL { url, error in
                completion(url)
            }

    }
}


