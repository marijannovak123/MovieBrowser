//
//  DomainType.swift
//  BeersApp
//
//  Created by Marijan on 23/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

protocol DomainData: Codable, Equatable {
    
    associatedtype DatabaseType: Persistable
    
    var uid: Int {get}
    
    func asDatabaseType() -> DatabaseType

}

extension Array where Element: DomainData {
    
    func asDatabaseType() -> [Element.DatabaseType] {
        return self.map { $0.asDatabaseType() }
    }
}

