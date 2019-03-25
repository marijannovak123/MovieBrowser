//
//  AuthService.swift
//  MovieBrowser
//
//  Created by UHP Mac on 23/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Foundation
import RxSwift

class AuthService: BaseService {
    
    func requestNewToken() -> Observable<TokenResponse> {
        return api.request(target: .newToken, responseType: TokenResponse.self)
    }
    
    func login(request: LoginRequest) -> Observable<TokenResponse> {
        return api.request(target: .login(request: request), responseType: TokenResponse.self)
    }
    
    func createSession(requestToken: String) -> Observable<SessionResponse> {
        return api.request(target: .createSession(requestToken: requestToken), responseType: SessionResponse.self)
    }
}
