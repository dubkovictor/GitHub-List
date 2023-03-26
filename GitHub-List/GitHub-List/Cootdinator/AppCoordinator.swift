//
//  AppCoordinator.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var navigationController : UINavigationController
    
    var isLoggedIn: Bool = false
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        openAuthVC()
    }
    
    func openAuthVC() {
        let vc = AppStoryboard.mainViewController.viewController(vc: MainViewController.self)
        vc.coordinator = self
        
        navigationController.pushViewController(vc, animated: false)
    }
    
}
