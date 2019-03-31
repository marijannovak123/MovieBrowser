//
//  ActionExtensions.swift
//  MovieBrowser
//
//  Created by Marijan on 31/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Action
import Moya

extension ActionError {
    
    private static let defaultMessage = "Unknown error"
    
    func resolveMessage() -> String {
        switch self {
        case .notEnabled:
            return ActionError.defaultMessage
        case .underlyingError(let error):
            if let resolvedError = error as? MoyaError {
                return NetworkError(resolvedError).errorMessage
            }
            return ActionError.defaultMessage
        }
    }
    
}
