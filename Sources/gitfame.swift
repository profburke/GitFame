//
//  gitfame.swift
//  GitFame
//
//  Created by Matthew Burke on 8/6/24.
//

import Foundation

@main
struct GitFetcher {
    let session = URLSession.shared
    let baseUrl = URL(string: "https://api.github.com/users")!
    private var sortType = SortType.byStars

    let user: String

    init(for user: String) {
        self.user = user
    }

    func fetch() async throws {
        print("... Fetching Stars (\(Unicode.star.yellow)) and Forks (\(Unicode.fork.green)) for GitHub user \(user.blue) on \(formattedDate()) ...\n")

        let count = try await fetchRepoCount()
        let repos = try await fetchRepos(count: count)

        let stars = repos.compactMap({ $0.stars }).reduce(0, +)
        let forks = repos.compactMap({ $0.forks }).reduce(0, +)
        let maxLen = repos.map { $0.name.count }.max() ?? 0

        for repo in repos.sorted(by: sortType.predicate) {
            print("\(repo.name.padded(to: maxLen + 4).red) \(repo.stars) \(Unicode.star.yellow) / \(repo.forks) \(Unicode.fork.green)")
        }

        print("\n\(user.blue)'s \(count) repos have \(stars) \(Unicode.star.yellow) and \(forks) \(Unicode.fork.green)\n")
    }

    private func fetchRepoCount() async throws -> Int {
        let url = baseUrl.appendingPathComponent(user)
        let (data, _) = try await session.data(from: url)
        let user = try JSONDecoder().decode(GitUser.self, from: data)

        return user.repoCount
    }

    private func fetchRepos(count: Int, includeForks: Bool = false) async throws -> [Repo] {
        let url = baseUrl
            .appendingPathComponent(user)
            .appendingPathComponent("repos")
            .appending(queryItems: [URLQueryItem(name: "per_page", value: "\(count)")])

        let (data, _) = try await session.data(from: url)
        let repos = try JSONDecoder().decode([Repo].self, from: data)

        return repos.filter { includeForks || $0.isFork == false }
    }

    static func main() async throws {
        guard CommandLine.arguments.count == 2 else {
            print("usage: gitfame <username>")
            return
        }

        print("... Welcome to \("GitFame".cyan)! ...")
        let gf = GitFetcher(for: CommandLine.arguments[1])
        try await gf.fetch()
    }
}
