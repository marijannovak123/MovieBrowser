//
//  AuthRepository.swift
//  MovieBrowser
//
//  Created by UHP Mac on 23/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Foundation

class AuthRepository {
    
    private let service: AuthService
    private let storage: AuthStorage
    
    init(service: AuthService, storage: AuthStorage) {
        self.service = service
        self.storage = storage
    }
}
