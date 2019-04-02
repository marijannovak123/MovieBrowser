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
    
    public static let sessionId = "sessionId"
    public static let defaultErrorMessage = "Unknown error"
    
    public static let imageUrlPrefix = "https://image.tmdb.org/t/p/w92"
}
