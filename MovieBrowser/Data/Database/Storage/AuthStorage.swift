//
//  AuthStorage.swift
//  MovieBrowser
//
//  Created by UHP Mac on 23/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import RxSwift

class AuthStorage: BaseStorage {
    
    func saveToken(response: TokenResponse) -> Observable<Void> {
        return Completable.fromAction {
            self.defaults.token = response.requestToken
            self.defaults.expiresAt = response.expiresAt
        }.asObservable().mapToVoid()
    }
}
