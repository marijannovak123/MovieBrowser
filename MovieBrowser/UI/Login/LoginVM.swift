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
    
    let isLoadingRelay = BehaviorRelay(value: false)
    let errorTracker = PublishSubject<Error>()
    
    struct Input {
        let loginTrigger: Driver<Void>
        let username: Driver<ValidatedText>
        let password: Driver<ValidatedText>
    }
    
    struct Output {
        let loginResult: Driver<UIResult<Void>>
        let isLoading: Driver<Bool>
    }
    
    private let repository: AuthRepository
    private let syncRepository: SyncRepository
    
    init(repository: AuthRepository, syncRepository: SyncRepository) {
        self.repository = repository
        self.syncRepository = syncRepository
    }
    
    func transform(input: LoginVM.Input) -> LoginVM.Output {
        let loginResult = input.loginTrigger
            .withLatestFrom (Driver.combineLatest(input.username, input.password))
            .filter { $0.0.isValid && $0.1.isValid }
            .asObservable()
            .startLoading(isLoadingRelay)
            .flatMapToResult { loginParams in
                self.repository.login(username: loginParams.0.value!, password: loginParams.1.value!)
            }.flatMapResult {
                self.syncRepository.fetchAndSaveLocalContent()
            }.stopLoading(isLoadingRelay)
            .map { $0.toUIResult() }
            .asDriver(onErrorJustReturn: UIResult.defaultError)
        
        return Output(loginResult: loginResult, isLoading: isLoadingRelay.asDriver())
    }
    
}
