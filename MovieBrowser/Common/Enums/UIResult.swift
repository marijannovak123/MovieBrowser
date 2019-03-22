//
//  UIResult.swift
//  BeersApp
//
//  Created by Marijan on 26/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

enum UIResult: Equatable {
    
    case error(_ message: String)
    case success(_ message: String)
    
    static func == (lhs: UIResult, rhs: UIResult) -> Bool {
        switch (lhs, rhs) {
        case (let .success(lMessage), let .success(rMessage)):
            return lMessage == rMessage
        case (let .error(lMessage), let .error(rMessage)):
            return lMessage == rMessage
        default:
            return false
        }
    }
}
