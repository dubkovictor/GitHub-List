//
//  APIFetcher.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import Foundation

protocol APIFetcherDelegate: AnyObject {
    func showError(message: String)
    func showProgress(_ show: Bool)
    func showResult(repositories: [Repository])
}

class APIFetcher {
    
    private weak var viewDelegate: APIFetcherDelegate?
    
    let service: APIServiceProtocol
    
    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }
    
    func setViewDelegate(_ delegate: APIFetcherDelegate) {
        viewDelegate = delegate
    }
    
    func fetchRepositories(query: String) {
        viewDelegate?.showProgress(true)
        service.getRepositories(query: query) { [unowned self] result in
            switch result {
                case .failure(let error):
                    viewDelegate?.showError(message: error.localizedDescription)
                    viewDelegate?.showProgress(false)
                case .success(let value):
                    viewDelegate?.showProgress(false)
                    viewDelegate?.showResult(repositories: value)
            }
        }
    }
}
