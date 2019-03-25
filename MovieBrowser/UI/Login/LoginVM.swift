//
//  LoginVM.swift
//  MovieBrowser
//
//  Created by UHP Mac on 23/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import RxSwift
import RxCocoa

class LoginVM: ViewModelType {
    
    struct Input {
        let loginTrigger: Driver<Void>
        let username: Driver<ValidatedText>
        let password: Driver<ValidatedText>
    }
    
    struct Output {
        let loginResult: Driver<UIResult>
    }
    
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func transform(input: LoginVM.Input) -> LoginVM.Output {
        let loginResult = input.loginTrigger
            .withLatestFrom (
                Driver.combineLatest(input.username, input.password)
            ).filter { (input) in
                let (usernameInput, passwordInput) = input
                return usernameInput.isValid && passwordInput.isValid
            }.asObservable()
            .flatMap { (parameters) -> Observable<Completion> in
                let (username, password) = parameters
                return self.repository.login(username: username.value!, password: password.value!)
            }.map {
                switch $0 {
                case .success:
                    return UIResult.success("Successfully logged in!")
                case .failure:
                    return UIResult.error("Error logging in")
                }
            }.asDriver(onErrorJustReturn: UIResult.error(""))
        
        return Output(loginResult: loginResult)
    }
}