//
//  BaseStorage.swift
//  Autism Helper iOS
//
//  Created by UHP Digital Mac 3 on 12.02.19.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxSwift

class BaseStorage {
    
    let databaseManager: DatabaseManager
    
    init(dbManager: DatabaseManager) {
        self.databaseManager = dbManager
    }
    
}
