//
//  Validation.swift
//  MovieBrowser
//
//  Created by UHP Mac on 25/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import UIKit

enum ValidationType {
    case notEmpty
    case isEmail
    case requiredLength(_ length: Int)
    
    func resolveFailedValidationMessage() -> String {
        switch self {
        case .notEmpty:
            return "Input required"
        case .isEmail:
            return "Malformed mail"
        case .requiredLength(let length):
            return "Must be at least \(length) chars long"
        }
    }
}

enum InputType {
    case regularText
    case email
    case password
    case username
    
    var validationTypes: [ValidationType] {
        switch self {
        case .regularText:
            return [.notEmpty]
        case .email:
            return [.notEmpty, .isEmail]
        case .password:
            return [.notEmpty, .requiredLength(3)]
        case .username:
            return [.notEmpty, .requiredLength(4)]
        }
    }
    
}


