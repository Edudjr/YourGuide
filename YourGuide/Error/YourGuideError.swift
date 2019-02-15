//
//  YourAPIError.swift
//  YourGuide
//
//  Created by Eduardo Domene Junior on 15/02/19.
//  Copyright © 2019 Eduardo Domene Junior. All rights reserved.
//

import Foundation

public enum YourGuideError: Error {
    case serverError
    case parsingError
}

extension YourGuideError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .serverError:
            return NSLocalizedString("A server error occurred. Try again later.", comment: "Error")
        case .parsingError:
            return NSLocalizedString("Something went wrong! Try again later.", comment: "Error")
        }
    }
}
