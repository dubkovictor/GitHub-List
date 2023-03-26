//
//  Repository.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import Foundation

// MARK: - Repository
struct Repository: Codable{
    let id: Int
    let name: String
    let owner: Owner
    let description: String?
    let htmlURL: String?
    let createdAt, updatedAt: String?
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
        case updatedAt = "updatedAt"
        case stargazersCount = "stargazersCount"
        case language
        case forksCount = "forksCount"
        case forks
    }
}

// MARK: - Owner
struct Owner: Codable {
    let login: String
    let id: Int
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatarUrl"
    }
}

struct BaseResponse: Codable {
    let items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}
