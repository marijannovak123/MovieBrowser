//
//  LoginVM.swift
//  MovieBrowser
//
//  Created by UHP Mac on 23/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Foundation

class LoginVM: ViewModelType {
    
    struct Input {}
    
    struct Output {}
    
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func transform(input: LoginVM.Input) -> LoginVM.Output {
        return Output()
    }
}
