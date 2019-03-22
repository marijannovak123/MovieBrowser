//
//  Persistable.swift
//  ios learning
//
//  Created by UHP Digital Mac 3 on 04.02.19.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

protocol Persistable where Self: BaseModel {
    
    associatedtype DomainType: DomainData
    
    func asDomain() -> DomainType
    
}

class BaseModel: Object {
    
    @objc dynamic var id = ""
    
    override static func primaryKey() -> String {
        return "id"
    }
    
}
