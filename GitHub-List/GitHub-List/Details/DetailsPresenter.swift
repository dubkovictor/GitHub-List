//
//  DetailsPresenter.swift
//  GitHub-List
//
//  Created by Victor on 27.03.2023.
//

import Foundation

class DetailsPresenter {
    
    private weak var viewDelegate: DetailsViewDelegate?
    
    func setViewDelegate(_ delegate: DetailsViewDelegate) {
        viewDelegate = delegate
    }
    
    var repository: Repository?
    
    func openSafary() {
        guard let repo = repository else  { return }
        
        viewDelegate?.openSafary(repository: repo)
    }
}


