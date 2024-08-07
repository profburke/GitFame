//
//  SortType.swift
//  GitFame
//
//  Created by Matthew Burke on 8/7/24.
//

enum SortType {
    case alphabetical
    case byForks
    case byStars

    var predicate: (Repo, Repo) -> Bool {
        switch self {
        case .alphabetical:
            return { a, b in a.name < b.name }
        case .byForks:
            return { a, b in a.forks > b.forks }
        case .byStars:
            return { a, b in a.stars > b.stars }
        }
    }
}
