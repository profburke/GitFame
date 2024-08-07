//
//  Models.swift
//  GitFame
//
//  Created by Matthew Burke on 8/6/24.
//

import Foundation

// MARK: - Github Data Structures

struct GitUser: Codable {
    let repoCount: Int
    let gistCount: Int

    enum CodingKeys: String, CodingKey {
        case repoCount = "public_repos"
        case gistCount = "public_gists"
    }
}

struct Repo: Codable {
    let name: String
    let forks: Int
    let stars: Int
    let isFork: Bool

    enum CodingKeys: String, CodingKey {
        case name
        case isFork = "fork"
        case forks = "forks_count"
        case stars = "stargazers_count"
    }
}
