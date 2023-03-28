//
//  AppDelegate.swift
//  GitHub-List
//
//  Created by Victor on 24.03.2023.
//

import UIKit
import Kingfisher

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var coordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let cache = ImageCache.default
        // Constrain Memory Cache to 10 MB
        cache.memoryStorage.config.totalCostLimit = 1024 * 1024 * 10
        
        // Constrain Disk Cache to 100 MB
        cache.diskStorage.config.sizeLimit = 1024 * 1024 * 100
        
        let navController = UINavigationController()
        coordinator = AppCoordinator(navigationController: navController)
        coordinator?.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
        
    }

}

