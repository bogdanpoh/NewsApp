//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 02.04.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var rootViewController: UINavigationController {
        return window?.rootViewController as! UINavigationController
    }
    
    // MARK: - Lifecycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        appCoordinator.start()
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("application did enter background")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("application will enter foreground")
        
        // TODO: update content
    }
    
    // MARK: - Private
    
    private lazy var appCoordinator = AppCoordinator(
        router: Router(rootController: rootViewController),
        coordinatorFactory: CoordinatorsFactory()
    )
        
    private let services: [UIApplicationDelegate] = []

}

// MARK: - Setup

private extension AppDelegate {
    
    func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = NavigationController()
        window?.makeKeyAndVisible()
    }
    
}
