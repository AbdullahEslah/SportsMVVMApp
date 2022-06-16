//
//  Connection.swift
//  SportsApp
//
//  Created by Macbook on 07/06/2022.
//

import Foundation
import Reachability

class ConnectionManager: NSObject {
    
    var reachability: Reachability!
    
    static let sharedInstance: ConnectionManager = { return ConnectionManager() }()
    
    
    override init() {
        super.init()

        reachability = try! Reachability()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
    }
    
    static func stopNotifier() -> Void {
        do {
            try (ConnectionManager.sharedInstance.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }

    static func isReachable(completed: @escaping (ConnectionManager) -> Void) {
        if (ConnectionManager.sharedInstance.reachability).connection != .unavailable {
            completed(ConnectionManager.sharedInstance)
        }
    }
    
    static func isUnreachable(completed: @escaping (ConnectionManager) -> Void) {
        if (ConnectionManager.sharedInstance.reachability).connection == .unavailable {
            completed(ConnectionManager.sharedInstance)
        }
    }
    
    static func isReachableViaWWAN(completed: @escaping (ConnectionManager) -> Void) {
        if (ConnectionManager.sharedInstance.reachability).connection == .cellular {
            completed(ConnectionManager.sharedInstance)
        }
    }

    static func isReachableViaWiFi(completed: @escaping (ConnectionManager) -> Void) {
        if (ConnectionManager.sharedInstance.reachability).connection == .wifi {
            completed(ConnectionManager.sharedInstance)
        }
    }
}
