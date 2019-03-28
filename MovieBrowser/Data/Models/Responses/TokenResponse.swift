//
//  TokenResponse.swift
//  MovieBrowser
//
//  Created by UHP Mac on 23/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Foundation

struct TokenResponse: Decodable {
    let success: Bool
    let expiresAt: String
    let requestToken: String
}
