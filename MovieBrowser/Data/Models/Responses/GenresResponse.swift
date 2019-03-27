//
//  GenresResponse.swift
//  MovieBrowser
//
//  Created by UHP Mac on 27/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Foundation

struct GenresResponse: Decodable {
    let genres: [Genre]
}
