//
//  UserDefaultsHelper.swift
//  MovieBrowser
//
//  Created by UHP Mac on 23/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Foundation

class UserDefaultsHelper {
    
    var sessionId: String {
        get {
            return getValue(for: Constants.sessionId) ?? ""
        }
        
        set {
            setValue(newValue, for: Constants.sessionId)
        }
    }
    
    var isLoggedIn: Bool {
        return !sessionId.isEmpty
    }
    
    func getValue<T>(for key: String) -> T? {
        return UserDefaults.standard.value(forKey: key) as! T?
    }
    
    func setValue<T>(_ value: T, for key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
}
