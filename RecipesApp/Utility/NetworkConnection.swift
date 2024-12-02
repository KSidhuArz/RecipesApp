//
//  NetworkConnection.swift
//  RecipesApp
//
//  Created by Ramandeep Singh on 11/26/24.
//

import Foundation
import Network

protocol Reachability{
    func execute() -> Bool
}

class NetworkConnection:Reachability{
    private let monitor:NWPathMonitor
    private let queue: DispatchQueue
    private var isConnected = true
    
    init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        monitor.pathUpdateHandler = { [weak self] path in self?.isConnected = path.status == .satisfied}
        monitor.start(queue: self.queue)
    }
    
    func execute() -> Bool {
        isConnected
    }
    
    
}
