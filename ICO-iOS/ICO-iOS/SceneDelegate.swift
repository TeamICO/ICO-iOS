//
//  SceneDelegate.swift
//  ICO
//
//  Created by do_yun on 2021/11/02.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    let jwtToken = UserDefaults.standard.string(forKey: "jwtToken")
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        //윈도우 씬을 가져온다.
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        
        let vc : UIViewController
        if jwtToken != nil{
            vc = BaseTBC()
        }else{
            let splashStoryboard = UIStoryboard(name: "LoginSB", bundle: nil)
     
            let loginVC = splashStoryboard.instantiateViewController(identifier: "LoginVC")
            loginVC.navigationItem.largeTitleDisplayMode = .never
            vc = UINavigationController(rootViewController: loginVC)
        }
        
      
        //뿌리 뷰 컨트롤러 설정
        window.rootViewController = vc
        //설정한 윈도우를 보이게 끔 설정
        window.makeKeyAndVisible()
        
        //윈도우 씬 설정
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

