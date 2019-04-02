//
//  ActionExtensions.swift
//  MovieBrowser
//
//  Created by Marijan on 31/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Action
import Moya

extension Optional where Wrapped == ActionError {
    
    private static let defaultMessage = "Unknown error"
    
    func resolveMessage() -> String {
        if let unwrapped = self {
            switch unwrapped {
            case .notEnabled:
                return Constants.defaultErrorMessage
            case .underlyingError(let error):
                if let resolvedError = error as? MoyaError {
                    return NetworkError(resolvedError).errorMessage
                }
                return Constants.defaultErrorMessage
            }
        } else {
            return Constants.defaultErrorMessage
        }
       
    }
    
}
