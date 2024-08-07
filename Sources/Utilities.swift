//
//  Utilities.swift
//  GitFame
//
//  Created by Matthew Burke on 8/7/24.
//

import Foundation

// MARK: - String extension for colored text

extension String {
    var blue: String { return Colors.blue + self + Colors.close }
    var cyan: String { return Colors.cyan + self + Colors.close }
    var green: String { return Colors.green + self + Colors.close }
    var red: String { return Colors.red + self + Colors.close }
    var yellow: String { return Colors.yellow + self + Colors.close }
}

// MARK: - String extension to pad text

extension String {
    func padded(to length: Int) -> String {
        let deficit = max(0, length - self.count)
        return self + String(repeating: " ", count: deficit)
    }
}

// MARK: - Helper functions

func formattedDate() -> String {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "MMM d, y h:mm:ss a"
    dateformatter.timeZone = TimeZone.current
    return dateformatter.string(from: Date())
}

