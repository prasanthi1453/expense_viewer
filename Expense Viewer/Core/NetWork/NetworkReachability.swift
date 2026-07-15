//
//  NetworkReachability.swift
//  Expense Viewer
//
//  Created by Prasanthi Somepalli on 15/07/26.
//


import Foundation
import Network

final class NetworkReachability {
    
    static let shared = NetworkReachability()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkReachability")
    
    private(set) var isConnected: Bool = true
    
    private init() { }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            self.isConnected = path.status == .satisfied
        }
        
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}