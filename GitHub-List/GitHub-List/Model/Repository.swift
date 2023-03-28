//
//  Repository.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import Foundation

// MARK: - Repository
struct Repository: Codable {
    var id: Int
    let name: String
    let owner: Owner
    let description: String?
    let htmlURL: String?
    let createdAt: String?
    let stargazersCount: Int
    let language: String?
    let forksCount: Int
    let forks: Int
   
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case htmlURL = "htmlUrl"
        case description
        case createdAt = "createdAt"
        case stargazersCount = "stargazersCount"
        case language
        case forksCount = "forksCount"
        case forks
    }
    
    static func create(with repo: RepositoryObject) -> Repository {
        let repository = Repository(id: repo.id,
                                    name: repo.name,
                                    owner: Owner.create(with: repo.owner ?? OwnerObject()),
                                    description: repo.descriptionText,
                                    htmlURL: repo.htmlURL,
                                    createdAt: repo.createdAt,
                                    stargazersCount: repo.stargazersCount,
                                    language: repo.language,
                                    forksCount: repo.forksCount,
                                    forks: repo.forks)
        return repository
    }
}

// MARK: - Owner
struct Owner: Codable {
    let id: Int
    let login: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatarUrl"
    }
    
    static func create(with repo: OwnerObject) -> Owner {
        let owner = Owner(id: repo.id, login: repo.login, avatarURL: repo.avatarURL)
        return owner
    }
}

struct BaseResponse: Codable {
    let items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}

