//
//  NetworkManager.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/12/02.
//

import Foundation
import Network
import RxSwift
final class NetworkManager{
    static let shared = NetworkManager()
    
    enum ConnectionType {
        case wifi
        case celluler
        case ethernet
        case unknown
    }
    
    private let queue = DispatchQueue.global()
    private let monitor : NWPathMonitor
    public private(set) var isConnected : Bool = false
    public private(set) var connectionType : ConnectionType = .unknown
    
    private init() {
        monitor = NWPathMonitor()
        
    }
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
            print(self?.isConnected ?? "x")
       
        }
    
    }
    func stopMonitoring() {
        monitor.cancel()
        
    }
    public func getConnectionType(_ path : NWPath ){
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
        }else if path.usesInterfaceType(.cellular){
            connectionType = .celluler
        }else if path.usesInterfaceType(.wiredEthernet){
            connectionType = .ethernet
        }else{
            connectionType = .unknown
        }
    }
    
}
