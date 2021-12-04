//
//  KakaoLoginManager.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/16.
//

import Foundation
import Alamofire
import KakaoSDKAuth
import KakaoSDKUser
import FirebaseMessaging
class LoginManager {
    static let shared = LoginManager()
    
    public func KakaoSignIn(completion: @escaping (String?) -> Void){
        if !AuthApi.hasToken(){
            if UserApi.isKakaoTalkLoginAvailable(){
                UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                        if let error = error {
                            print("로그인 실패 에러 : \(error)")

                        }
                        else {
                            print("로그인 성공")
                            
                            _ = oauthToken
                            if let accessToken = oauthToken?.accessToken{
                                completion(accessToken)
                            }
                           
                        }
                    
                }
         
            }else{
                UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                        if let error = error {
                            print("로그인 실패 에러 : \(error)")

                        }
                        else {
                            print("로그인 성공")
                            
                            _ = oauthToken
                            if let accessToken = oauthToken?.accessToken{
                                completion(accessToken)
                            }
                           
                        }
                }
            }

        }else{
            print("로그아웃 필요")
            LoginManager.shared.signOut { success in
                guard success else{
                    return
                }
                completion(nil)
                
            }
           
        }
       
    }

    public func registerID(name : String?,snsToken : String,snsType: String,deviceToken: String?, completion: @escaping (LoginResponse?)->Void) {
      
        let url = "https://prod.chuckwagon.shop/app/login"
       
        let param = [
            "snsToken" : snsToken,
            "snsType" : snsType,
            "pushToken" : deviceToken ?? "",
            "name" : name ?? ""
        ]
  
        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: nil)
            .responseDecodable(of: LoginResponse.self) { response in
                
                switch response.result  {
                
                case .success(let response):
                   
                    completion(response)
                    
                    
                    
                case .failure(let error):
                    print("DEBUG>> registerID Get Error : \(error.localizedDescription)")
                    
                }
            }
        
    }
    
    
    public func signOut(completion: @escaping (Bool) -> Void){
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
                completion(false)
                
            }
            else {
                print("logout() success.")
                completion(true)
            }
        }
    }
}
