//
//  Genre.swift
//  MovieBrowser
//
//  Created by UHP Mac on 27/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Foundation

struct Genre: DomainData {
    
    let id: Int
    let name: String
    
    var uid: Int {
       return id
    }
    
    func asDatabaseType() -> DBGenre {
        let dbGenre = DBGenre()
        dbGenre.id = self.id
        dbGenre.name = self.name
        return dbGenre
    }
    
}
