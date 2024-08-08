//
//  SortType.swift
//  GitFame
//
//  Created by Matthew Burke on 8/7/24.
//

import ArgumentParser

enum SortType: EnumerableFlag {
    case forks
    case name
    case stars

    var predicate: (Repo, Repo) -> Bool {
        switch self {
        case .forks:
            return { a, b in a.forks > b.forks }
        case .name:
            return { a, b in a.name < b.name }
        case .stars:
            return { a, b in a.stars > b.stars }
        }
    }
}
