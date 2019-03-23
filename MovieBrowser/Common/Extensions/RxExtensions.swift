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

extension ObservableType where E == Bool {
    /// Boolean not operator
    public func not() -> Observable<Bool> {
        return self.map(!)
    }
    
}

extension SharedSequenceConvertibleType {
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}

extension ObservableType {
    
    func catchErrorJustComplete() -> Observable<E> {
        return catchError { _ in
            return Observable.empty()
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<E> {
        return asDriver { error in
            return Driver.empty()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }

}
