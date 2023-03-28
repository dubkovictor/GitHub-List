//
//  MainViewDelegate.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import Foundation

protocol MainViewDelegate: AnyObject {
    func showProgress(show: Bool)
    func showError(message: String)
    func showRepos(repos: [Repository])
}
