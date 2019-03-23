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
        let username: Driver<String>
        let password: Driver<String>
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
            ).asObservable()
            .flatMap { (parameters) -> Observable<Bool> in
                let (username, password) = parameters
                return self.repository.login(username: username, password: password)
                    .catchErrorJustReturn(false)
            }.map {
                if $0 {
                   return UIResult.success("Good")
                } else {
                    return UIResult.error("No good")
                }
            }.asDriver(onErrorJustReturn: UIResult.error(""))
        
        return Output(loginResult: loginResult)
    }
}
