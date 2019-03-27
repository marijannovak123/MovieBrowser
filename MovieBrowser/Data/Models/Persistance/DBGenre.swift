//
//  DBGenre.swift
//  MovieBrowser
//
//  Created by UHP Mac on 27/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Foundation

class DBGenre: BaseModel, Persistable {
    
    @objc dynamic var name = ""
    
    func asDomain() -> Genre {
        return Genre(id: self.id, name: self.name)
    }
}
