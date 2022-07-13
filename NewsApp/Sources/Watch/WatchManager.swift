//
//  WatchManager.swift
//  NewsApp
//
//  Created by Bohdan Pokhidnia on 13.07.2022.
//

import WatchConnectivity

private let watchLogger = Logger(identifier: "WatchManager")

fileprivate enum WatchTranserType: String {
    case country
}

final class WatchManager: NSObject {
    
    var onReceiveCountry: ((Country) -> Void)?
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        
        activate()
    }
    
    // MARK: - Private
    
    private var session: WCSession?
    
}

// MARK: - Private Methods

private extension WatchManager {
    
    func activate() {
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
}

// MARK: - WCSessionDelegate

extension WatchManager: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        watchLogger.info("\(#function) \(activationState)")
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        receiveUserInfo(userInfo)
    }
    
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        watchLogger.info("\(#function)")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        watchLogger.info("\(#function)")
    }
    #endif
    
}

// MARK: - WatchManagerProtocol

extension WatchManager: WatchManagerProtocol {
    
    func send(_ country: Country) {
        guard let session = session else { return }
        
        let sendUserInfo: ((WatchTranserType, Country) -> Void) = { [weak session] (transferType, country) in
            session?.transferUserInfo([transferType.rawValue: country.rawValue])
        }
        
        #if os(iOS)
        if session.isPaired && session.isWatchAppInstalled {
            sendUserInfo(.country, country)
        } else {
            watchLogger.error("Error send from phone, isPaired \(session.isPaired), watch app installed \(session.isWatchAppInstalled)")
        }
        #else
        if session.isReachable {
            sendUserInfo(.country, country)
        } else {
            watchLogger.error("Error send from watch, reachable: \(session.isReachable)")
        }
        #endif
    }
    
}

// MARK: - Receive data

private extension WatchManager {
    
    func receiveUserInfo(_ userInfo: [String: Any]) {
        guard let context = userInfo.first else { return }
        guard let transferType = WatchTranserType(rawValue: context.key) else { return }
        
        switch transferType {
        case .country:
            guard let contextValue = context.value as? String else { return }
            guard let country = Country(rawValue: contextValue) else { return }
            onReceiveCountry?(country)
            
            watchLogger.info("received country: \(country)")
        }
    }
    
}
