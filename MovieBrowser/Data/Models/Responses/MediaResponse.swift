//
//  MediaResponse.swift
//  MovieBrowser
//
//  Created by UHP Mac on 02/04/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Foundation

struct MediaResponse<T>: Decodable where T: Decodable {
    let page: Int
    let results: [T]
    let totalPages: Int
    let totalResults: Int
}
