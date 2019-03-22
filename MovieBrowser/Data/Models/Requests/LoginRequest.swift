//
//  LoginRequest.swift
//  MovieBrowser
//
//  Created by UHP Mac on 22/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Foundation

struct LoginRequest: Encodable {
    let username: String
    let password: String
    let requestToken: String
}
