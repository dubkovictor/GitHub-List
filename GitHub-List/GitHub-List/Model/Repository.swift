//
//  Repository.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import Foundation

// MARK: - Repository
struct Repository: Decodable {
    let id: Int
    let name: String
    let owner: Owner
    let description: String
    let htmlURL: String?
    let createdAt, updatedAt: String
    let language: String?
    let forksCount: Int?
    let forks: Int
    let stargazersCount: Int
}

// MARK: - Owner
struct Owner: Decodable {
    let login: String
    let id: Int
    let avatarURL: String?
    //let gravatarID: String
    //let url, htmlURL, followersURL: String
    //let followingURL, gistsURL, starredURL: String
    //let subscriptionsURL, organizationsURL, reposURL: String
    //let eventsURL: String
    //let receivedEventsURL: String
    //let type: TypeEnum
    //let siteAdmin: Bool
}

struct BaseResponse: Decodable {
    //let totalCount: Int
    //let incompleteResults: Bool
    let items: [Repository]
}
