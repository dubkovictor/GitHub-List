//
//  Coordinator.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import UIKit

protocol Coordinator {
    
    var navigationController : UINavigationController { get set }
    
    func start()
}
