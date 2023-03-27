//
//  FavoritePresenter.swift
//  GitHub-List
//
//  Created by Victor on 27.03.2023.
//

import Foundation
import RealmSwift

class FavoritePresenter {
    
    private weak var viewDelegate: FavoriteViewDelegate?
    
    let realm = try! Realm()
    
    func setViewDelegate(_ delegate: FavoriteViewDelegate) {
        viewDelegate = delegate
    }

    func fetchData() {
        let data = realm.objects(RepositoryObject.self)
        
        viewDelegate?.showRepos(repos: Array(data))
    }
    
    func remove(repo: RepositoryObject) {
        try! realm.write {
            realm.delete(repo)
        }
    }
}
