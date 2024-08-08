//
//  gitfame.swift
//  GitFame
//
//  Created by Matthew Burke on 8/6/24.
//

import ArgumentParser
import Foundation

@main
struct GitFetcher: AsyncParsableCommand {
    enum CodingKeys: String, CodingKey {
        case includeForks
        case sortType
        case user
    }

    let session = URLSession.shared
    let baseUrl = URL(string: "https://api.github.com/users")!

    @Flag(name: .customShort("a"), help: "List all repositories, including forks.")
    private var includeForks = false

    @Flag(help: "Specify how to sort the output.")
    private var sortType: SortType = .stars

    @Argument(help: "The GitHub user to check.")
    private var user: String

    func run() async  {
        print("... Welcome to \("GitFame".cyan)! ...")
        print("... Fetching Stars (\(Unicode.star.yellow)) and Forks (\(Unicode.fork.green)) for GitHub user \(user.blue) on \(formattedDate()) ...\n")

        print("includeForks: \(includeForks)")

        do {
            // Total is the number of public repos (including forks)
            let total = try await fetchTotalRepos()
            // repos may have fewer than `total` elements if `includeForks` is false.
            // That's why we use `repos.count` when printing the summary line below.
            let repos = try await fetchRepos(count: total)

            let stars = repos.compactMap({ $0.stars }).reduce(0, +)
            let forks = repos.compactMap({ $0.forks }).reduce(0, +)
            let maxLen = repos.map { $0.name.count }.max() ?? 0

            for repo in repos.sorted(by: sortType.predicate) {
                print("\(repo.name.padded(to: maxLen + 4).red) \(repo.stars) \(Unicode.star.yellow) / \(repo.forks) \(Unicode.fork.green)")
            }

            print("\n\(user.blue)'s \(repos.count) repos have \(stars) \(Unicode.star.yellow) and \(forks) \(Unicode.fork.green)\n")
        } catch {
            print("gitfame: \(error.localizedDescription)")
        }
    }

    // more accurately, fetchTotalPUBLICRepos()
    private func fetchTotalRepos() async throws -> Int {
        let url = baseUrl.appendingPathComponent(user)
        let (data, _) = try await session.data(from: url)
        let user = try JSONDecoder().decode(GitUser.self, from: data)

        return user.repoCount
    }

    // more accurately, fetchPUBLICRepos()
    private func fetchRepos(count: Int) async throws -> [Repo] {
        let url = baseUrl
            .appendingPathComponent(user)
            .appendingPathComponent("repos")
            .appending(queryItems: [URLQueryItem(name: "per_page", value: "\(count)")])

        let (data, _) = try await session.data(from: url)
        let repos = try JSONDecoder().decode([Repo].self, from: data)

        return repos.filter { includeForks || $0.isFork == false }
    }
}
