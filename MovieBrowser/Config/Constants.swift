//
//  Constants.swift
//  MovieBrowser
//
//  Created by UHP Mac on 22/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Foundation

class Constants {
    
    private init() {}
    
    public static var apiKey: String {
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            if let keysDictionary = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> {
                return keysDictionary["API Key"] as! String
            }
        }
        
        return ""
    }
}
