//
//  MainPresenter.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import Foundation

class MainPresenter {
    
    private weak var viewDelegate: MainViewDelegate?
    
    private var apiFetcher = APIFetcher()
    
    var query: String = ""
    
    func setViewDelegate(_ delegate: MainViewDelegate) {
        viewDelegate = delegate
    }
    
    init() {
        apiFetcher.setViewDelegate(self)
    }
    
    func fetcher() {
        apiFetcher.fetchRepositories(query: "222")
    }
}

extension MainPresenter: APIFetcherDelegate {
    func showError(message: String) {
        
    }
    
    func showProgress(_ show: Bool) {
        viewDelegate?.showProgress(show: show)
    }
    
    func showResult(repositories: [Repository]) {
        viewDelegate?.showRepos(repos: repositories)
    }
    
    
}
