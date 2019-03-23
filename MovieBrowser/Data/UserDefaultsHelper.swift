//
//  UserDefaultsHelper.swift
//  MovieBrowser
//
//  Created by UHP Mac on 23/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Foundation

class UserDefaultsHelper {
    
    var token: String {
        get {
            return UserDefaults.standard.value(forKey: Constants.keyToken) as! String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Constants.keyToken)
        }
    }
    
    var expiresAt: String {
        get {
            return UserDefaults.standard.value(forKey: Constants.expiresAt) as! String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Constants.expiresAt)
        }
    }
    
}
