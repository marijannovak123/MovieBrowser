//
//  LoginVM.swift
//  MovieBrowser
//
//  Created by UHP Mac on 23/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import RxSwift
import RxCocoa
import RxSwiftExt

class LoginVM: ViewModelType {
    
    let isLoadingRelay = BehaviorRelay.init(value: false)
    
    struct Input {
        let loginTrigger: Driver<Void>
        let username: Driver<ValidatedText>
        let password: Driver<ValidatedText>
    }
    
    struct Output {
        let loginSuccess: Driver<Void>
        let loginErrors: Driver<String>
        let isLoading: Driver<Bool>
    }
    
    private let repository: AuthRepository
    private let syncRepository: SyncRepository
    
    init(repository: AuthRepository, syncRepository: SyncRepository) {
        self.repository = repository
        self.syncRepository = syncRepository
    }
    
    func transform(input: LoginVM.Input) -> LoginVM.Output {
        let loginObservable = input.loginTrigger
            .withLatestFrom (Driver.combineLatest(input.username, input.password))
            .filter { $0.0.isValid && $0.1.isValid }
            .do(onNext: { _ in self.isLoadingRelay.accept(true) })
            .asObservable()
            .flatMap {
                self.repository.login(username: $0.0.value!, password: $0.1.value!)
            }.flatMap {result -> Observable<Void> in
                self.syncRepository.fetchAndSaveLocalContent()
            }.materialize()

        let loginResult = loginObservable.elements()
            .asDriver(onErrorJustReturn: ())
            .do ( onNext: { _ in self.isLoadingRelay.accept(false) })

        let loginErrors = loginObservable.errors()
            .map { error in error.localizedDescription }
            .asDriver(onErrorJustReturn: "Errorings")
            .do ( onNext: { _ in self.isLoadingRelay.accept(false) })
        
        return Output(loginSuccess: loginResult, loginErrors: loginErrors, isLoading: isLoadingRelay.asDriver())
    }
    
    func syncContent() -> Observable<Void> {
        return syncRepository.fetchAndSaveLocalContent()
    }
}
