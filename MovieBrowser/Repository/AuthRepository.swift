//
//  AuthRepository.swift
//  MovieBrowser
//
//  Created by UHP Mac on 23/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import RxSwift
import Moya

class AuthRepository {
    
    private let service: AuthService
    private let storage: AuthStorage
    
    init(service: AuthService, storage: AuthStorage) {
        self.service = service
        self.storage = storage
    }
    
    func login(username: String, password: String) -> Observable<Completion> {
        return service.requestNewToken()
            .flatMap {
                self.service.login(request: LoginRequest(username: username, password: password, requestToken: $0.requestToken))
            }.flatMap { tokenResponse in
                self.service.createSession(requestToken: tokenResponse.requestToken)
            }.flatMap { sessionIdResponse in
                self.storage.saveSession(response: sessionIdResponse)
            }.map { _ in Completion.success }
            .catchErrorJustReturn(.failure)
    }
}
