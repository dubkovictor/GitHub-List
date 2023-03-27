//
//  FavoriteViewDelegate.swift
//  GitHub-List
//
//  Created by Victor on 27.03.2023.
//

import Foundation

protocol FavoriteViewDelegate: AnyObject {
    
    func showRepos(repos: [RepositoryObject])
    
}
