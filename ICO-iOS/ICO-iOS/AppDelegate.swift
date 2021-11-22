//
//  AppDelegate.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//

import UIKit
import CoreMedia
import KakaoSDKCommon
import KakaoSDKAuth
import NaverThirdPartyLogin
import Firebase
import FirebaseMessaging
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UserDefaults.standard.set("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4Ijo3LCJpYXQiOjE2MzY2NTA1MjIsImV4cCI6MTY2ODE4NjUyMiwic3ViIjoidXNlckluZm8ifQ.jLgh0f3iW_2y4RzSQzLFEXKlXJSHyD7cCb4czAWGnVo",forKey: "jwtToken")
        FirebaseApp.configure()
        registerRemoteNotification()
        setKakaoSDK()
        setNaverSDK()
        checkUser()
        
     


    
        return true
    }
    // MARK: Login
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            // NAVER
            NaverThirdPartyLoginConnection.getSharedInstance()?.application(app, open: url, options: options)
            return true
        }
    // MARK: Push
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            Messaging.messaging().apnsToken = deviceToken
        }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func checkUser(){
        if let jwtToken = UserDefaults.standard.string(forKey: "jwtToken"){
            
            BaseManager.shared.getUserIdx(jwtToken: jwtToken) { response in
                UserDefaults.standard.set(response.userIdx, forKey: "userIdx")
                UserDefaults.standard.set(response.nickname, forKey: "nickname")
            }
        }
    }
    
    func setKakaoSDK(){
        KakaoSDKCommon.initSDK(appKey: "45a3f8115adddf6e9e9cb8193a5b1fb4")
        
        
    }
    func setNaverSDK(){
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
           
           // 네이버 앱으로 인증하는 방식을 활성화
           instance?.isNaverAppOauthEnable = true
           
           // SafariViewController에서 인증하는 방식을 활성화
           instance?.isInAppOauthEnable = true
           
           // 인증 화면을 iPhone의 세로 모드에서만 사용하기
           instance?.isOnlyPortraitSupportedInIphone()
           
           // 네이버 아이디로 로그인하기 설정
           // 애플리케이션을 등록할 때 입력한 URL Scheme
           instance?.serviceUrlScheme = kServiceAppUrlScheme
           // 애플리케이션 등록 후 발급받은 클라이언트 아이디
           instance?.consumerKey = kConsumerKey
           // 애플리케이션 등록 후 발급받은 클라이언트 시크릿
           instance?.consumerSecret = kConsumerSecret
           // 애플리케이션 이름
           instance?.appName = kServiceAppName
           
    }
    private func registerRemoteNotification() {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            let options: UNAuthorizationOptions = [.alert, .sound, .badge]
            center.requestAuthorization(options: options) { granted, _ in
                // 1. APNs에 device token 등록 요청
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

    /// Foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }

    // FCM에서 푸시를 탭했을 때 url 처리
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse)  {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        print(userInfo["url"] as? String)
        guard let deepLinkUrl = userInfo["url"] as? String,
            let url = URL(string: deepLinkUrl) else { return }

        // 해당 host를 가지고 있는지 확인
        guard url.host == "navigation" else { return }

        // 원하는 query parameter가 있는지 확인
        let urlString = url.absoluteString
        guard urlString.contains("target"), urlString.contains("promotionCode") else { return }

        // URL을 URLComponent로 만들어서 parameter값 가져오기 쉽게 접근
        let components = URLComponents(string: urlString)

        // URLQueryItem 형식은 [name: value] 쌍으로 되어있으서 Dctionary로 변형
        let urlQueryItems = components?.queryItems ?? []
        var dictionaryData = [String: String]()
        urlQueryItems.forEach { dictionaryData[$0.name] = $0.value }
        guard let target = dictionaryData["target"],
            let promotionCode = dictionaryData["promotionCode"] else { return }

        print("결과 = \(target), \(promotionCode)")
        routeToThirdScene(with: promotionCode)
        
    }

    private func routeToThirdScene(with promotinoCode: String) {
        // 타겟 화면인 ViewController3 초기화
        let storyboard = UIStoryboard(name: "MainSB", bundle: Bundle.main)
        guard let viewController3 = storyboard.instantiateViewController(withIdentifier: "BaseTBC") as? BaseTBC else { return }
        

        /// 이미 로그인 이 된 경우, 바로 present
        if let jwtToken = UserDefaults.standard.string(forKey: "jwtToken") {
            // 타겟 화면을 띄울 window의 rootViewController 참조
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
            let rootViewController = sceneDelegate.window?.rootViewController
            rootViewController?.present(viewController3, animated: true, completion: nil)
        } else {
            /// 로그인이 안되어 있는 경우, 로그인 완료 시 나오는 페이지에 타겟 화면이 표출되도록 예약
        }
    }
}
