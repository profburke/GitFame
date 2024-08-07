//
//  Constants.swift
//  GitFame
//
//  Created by Matthew Burke on 8/6/24.
//

// MARK: - General Constants

struct Unicode {
    static let star = "\u{2605}"
    static let fork = "\u{2442}"
}

// MARK: - Color Constants (w/built-in escapes; \u{001B})

struct Colors {
    static let blue = "\u{001B}[34m"
    static let close = "\u{001B}[0m"
    static let cyan = "\u{001B}[36m"
    static let green = "\u{001B}[32m"
    static let red = "\u{001B}[31m"
    static let yellow = "\u{001B}[33m"
}

