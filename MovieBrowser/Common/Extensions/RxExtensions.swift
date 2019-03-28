//
//  RxExtensions.swift
//  Autism Helper iOS
//
//  Created by UHP Digital Mac 3 on 14.02.19.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension PrimitiveSequenceType where TraitType == CompletableTrait, ElementType == Never {
    
    // invoke a simple complete
    static func complete() -> Completable {
        return Completable.create { emitter in
            emitter(.completed)
            return Disposables.create()
        }
    }
    
    static func fromAction(block: @escaping () -> Void) -> Completable {
        return Completable.create { emitter in
            block()
            emitter(.completed)
            return Disposables.create()
        }
    }
}

extension PrimitiveSequenceType where TraitType == SingleTrait {
    
    static func fromCallable<T>(_ callBlock: @escaping () throws -> T) -> Single<T> {
        return Single.create { emitter in
            do {
               let result = try callBlock()
                emitter(.success(result))
            } catch let error as NSError {
                emitter(.error(error))
            }
            
            return Disposables.create()
        }
    }
   
}

extension SharedSequenceConvertibleType {
    
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}

extension ObservableType {
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }

    static func fromAction(block: @escaping () -> Void) -> Observable<Void> {
        return Observable.deferred {.just(block())}
    }
    
    func startLoading(_ loadingRelay: BehaviorRelay<Bool>) -> Observable<Self.E> {
        return self.do(onNext: { _ in loadingRelay.accept(true) })
    }
    
    func stopLoading(_ loadingRelay: BehaviorRelay<Bool>) -> Observable<Self.E> {
        return self.do (
            onNext: { _ in loadingRelay.accept(false) },
            onError: { _ in loadingRelay.accept(false) }
        )
    }
    
}


extension ObservableType {
    
    typealias ResultWrapper<A> = Observable<Result<A, Error>>
    
    func flatMapResult<Input, Output>(_ selector: @escaping (Input) throws -> Observable<Output>) -> ResultWrapper<Output> where E == Result<Input, Error> {
        return self.flatMap { (result: Result<Input, Error>) -> ResultWrapper<Output> in
            switch result {
            case .success(let data):
                return try selector(data)
                    .map { .success($0) }
                    .catchError { .just(.failure($0)) }
            case .failure(let error):
                return .just(.failure(error))
            }
        }
    }
    
    func flatMapToResult<Output>(_ selector: @escaping (E) throws -> Observable<Output>) -> ResultWrapper<Output> {
        return self.flatMap { param -> ResultWrapper<Output> in
            return try selector(param)
                .map { .success($0) }
                .catchError { .just(.failure($0)) }
        }
    }

}

extension PublishSubject where E == Error {
    
    func stopLoadingOnError(_ loadingRelay: BehaviorRelay<Bool>) -> Observable<E> {
        return self.do(onNext: { _ in loadingRelay.accept(false) } )
    }
}
