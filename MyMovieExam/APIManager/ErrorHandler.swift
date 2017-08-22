//
//  ErrorHandler.swift
//

import UIKit

// MARK: - Network

enum ErrorNetwork: Error {
    case offline
    case serverError
}

extension ErrorNetwork: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .offline:
            return NSLocalizedString("Your device is not connected to the internet.", comment: "No internet connection")
        case .serverError:
            return NSLocalizedString("Server connection issue try again.", comment: "Server connection issue try again")

        }
    }
}
