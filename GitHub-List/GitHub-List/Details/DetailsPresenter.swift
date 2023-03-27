//
//  DetailsPresenter.swift
//  GitHub-List
//
//  Created by Victor on 27.03.2023.
//

import Foundation
import RealmSwift

class DetailsPresenter {
    let realm = try! Realm()
    
    private weak var viewDelegate: DetailsViewDelegate?
    
    func setViewDelegate(_ delegate: DetailsViewDelegate) {
        viewDelegate = delegate
    }
    
    var repository: Repository?
    
    func openSafary() {
        guard let repo = repository else  { return }
        
        viewDelegate?.openSafary(repository: repo)
    }
    
    func addToFavorite() { // todo move to another layer
        guard let repo = repository else  { return }
        
        let favoriteRepo = RepositoryObject.create(with: repo)
        try! realm.write {
            realm.add(favoriteRepo)
        }
    }
}


