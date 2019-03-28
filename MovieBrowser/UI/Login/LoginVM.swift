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
    
    let isLoadingRelay = BehaviorRelay(value: false)
    let errorTracker = PublishSubject<Error>()
    
    struct Input {
        let loginTrigger: Driver<Void>
        let username: Driver<ValidatedText>
        let password: Driver<ValidatedText>
    }
    
    struct Output {
        let loginSuccess: Driver<Void>
        let loginError: Driver<String>
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
            .asObservable()
            .startLoading(isLoadingRelay)
            .flatMapMaterialized(errorTracker) {
                self.repository.login(username: $0.0.value!, password: $0.1.value!)
            }.flatMapMaterialized(errorTracker) {
                self.syncRepository.fetchAndSaveLocalContent()
            }.stopLoading(isLoadingRelay)
            .asDriver(onErrorJustReturn: ())
 
        let loginError = errorTracker
            .stopLoadingOnError(isLoadingRelay)
            .map { $0.localizedDescription }
            .asDriver(onErrorJustReturn: "Kita error")
        
        return Output(loginSuccess: loginObservable, loginError: loginError, isLoading: isLoadingRelay.asDriver())
    }
    
}
