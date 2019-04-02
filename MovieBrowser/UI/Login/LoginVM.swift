//
//  LoginVM.swift
//  MovieBrowser
//
//  Created by UHP Mac on 23/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

class LoginVM: ViewModelType {
    
    struct Input {
        let username: Driver<ValidatedText>
        let password: Driver<ValidatedText>
    }
    
    struct Output {
        let isLoading: Driver<Bool>
        let loginAction: Action<Void, Void>
    }
    
    private let repository: AuthRepository
    private let syncRepository: SyncRepository
    
    private let isLoadingRelay = BehaviorRelay(value: false)
    
    init(repository: AuthRepository, syncRepository: SyncRepository) {
        self.repository = repository
        self.syncRepository = syncRepository
    }
    
    func transform(input: LoginVM.Input) -> LoginVM.Output {
        let isEnabled = Driver.combineLatest(input.username, input.password)
            .map { $0.isValid && $1.isValid }
            .asObservable()
        
        let loginAction = Action<Void, Void>(enabledIf: isEnabled, workFactory: {
            return Driver.combineLatest(input.username, input.password)
                .map { ($0.0.value!, $0.1.value!) }
                .asObservable()
                .startActionLoading(self.isLoadingRelay)
                .flatMap {
                    self.repository.login(username: $0.0, password: $0.1)
                }.flatMap {
                    self.syncRepository.fetchAndSaveLocalContent()
                }.stopActionLoading(self.isLoadingRelay)
        })
        
        return Output(isLoading: isLoadingRelay.asDriver(), loginAction: loginAction)
    }
    
}
