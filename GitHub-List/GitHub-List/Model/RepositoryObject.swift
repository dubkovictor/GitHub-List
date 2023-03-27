//
//  RepositoryObject.swift
//  GitHub-List
//
//  Created by Victor on 27.03.2023.
//

import Foundation
import RealmSwift

class RepositoryObject: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var descriptionText: String = ""
    @objc dynamic var htmlURL: String = ""
    @objc dynamic var createdAt: String = ""
    @objc dynamic var stargazersCount: Int = 0
    @objc dynamic var language: String = ""
    @objc dynamic var forksCount: Int = 0
    @objc dynamic var forks: Int = 0
    @objc dynamic var owner: OwnerObject? = OwnerObject()
    
    static func create(with repo: Repository) -> RepositoryObject {
        let repository = RepositoryObject()
        repository.id = repo.id
        repository.name = repo.name
        repository.descriptionText = repo.description ?? ""
        repository.htmlURL = repo.htmlURL ?? ""
        repository.createdAt = repo.createdAt ?? ""
        repository.stargazersCount = repo.stargazersCount
        repository.language = repo.language ?? ""
        repository.forksCount = repo.forksCount
        repository.forks = repo.forks
        repository.owner = OwnerObject.create(with: repo.owner)
        return repository
    }
}

class OwnerObject: Object, Codable {
    
    @objc dynamic var login: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var avatarURL: String = ""
    
    static func create(with owner: Owner) -> OwnerObject {
        let object = OwnerObject()
        object.id = owner.id
        object.login = owner.login
        object.avatarURL = owner.avatarURL
        
        return object
    }
}
