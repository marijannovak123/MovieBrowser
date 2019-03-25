//
//  AuthStorage.swift
//  MovieBrowser
//
//  Created by UHP Mac on 23/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import RxSwift

class AuthStorage: BaseStorage {
    
    func saveSession(response: SessionResponse) -> Observable<Void> {
        return Observable<Void>.fromAction {
            self.defaults.sessionId = response.sessionId
        }
    }
}
