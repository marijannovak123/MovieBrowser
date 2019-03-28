//
//  UIResult.swift
//  BeersApp
//
//  Created by Marijan on 26/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

enum UIResult<T> {
    case error(_ message: String)
    case success(_ data: T)
    
    static var defaultError: UIResult {
        return .error("Unknown error")
    }
}
