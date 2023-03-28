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
    
    func openDetailsVC(repo: Repository, isSaved: Bool) {
        let vc = AppStoryboard.detailsViewController.viewController(vc: DetailsViewController.self)
        vc.presenter.repository = repo
        vc.isSaved = isSaved
        navigationController.navigationBar.topItem?.title = "Main"
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openFavoriteVC() {
        let vc = AppStoryboard.favoriteViewController.viewController(vc: FavoriteViewController.self)
        vc.coordinator = self
        navigationController.navigationBar.topItem?.title = "Main"
        navigationController.pushViewController(vc, animated: true)
    }
    
}
