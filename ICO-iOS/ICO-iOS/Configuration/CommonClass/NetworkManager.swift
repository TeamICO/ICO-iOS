//
//  NetworkManager.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/12/02.
//

import Foundation
import Network
final class NetworkManager{
    static let shared = NetworkManager()
    private init() {}
    let monitor = NWPathMonitor()
    func startMonitoring() {
        
        monitor.start(queue: .global())
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                print("connected")
                self?.monitor.cancel()
            } else {
                print("not connected")
                self?.monitor.cancel()
            }
            if path.usesInterfaceType(.wifi) {
                print("wifi mode")
                self?.monitor.cancel()
                
            } else if path.usesInterfaceType(.cellular) {
                print("cellular mode")
                self?.monitor.cancel()
                
            }
       
        }
    
    }
    func stopMonitoring() {
        monitor.cancel()
        
    }

    
}
