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
    
    var uid: String {get}
    
    func asDatabaseType() -> DatabaseType
   
}


