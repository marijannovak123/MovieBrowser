//
//  RealmRx.swift
//  BeersApp
//
//  Created by Marijan on 23/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

extension Reactive where Base: Realm {
    func save<T: DomainData>(entity: T, update: Bool = true) -> Observable<Void> {
        return Observable.create { observer in
            do {
                try self.base.write {
                    self.base.add(entity.asDatabaseType(), update: update)
                }
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func saveMultiple<T: DomainData>(entities: [T], update: Bool = true) -> Observable<Void> {
        return Observable.create { observer in
            do {
                try self.base.write {
                    self.base.add(entities.asDatabaseType(), update: update)
                }
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func delete<T: DomainData>(entity: T) -> Observable<Void> {
        return Observable.create { observer in
            do {
                guard let object = self.base.object(ofType: T.DatabaseType.self, forPrimaryKey: entity.uid) else { fatalError() }
                
                try self.base.write {
                    self.base.delete(object)
                }
                
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func deleteMultiple<T: DomainData>(entities: [T]) -> Observable<Void> {
        var requests = [Observable<Void>]()
        
        for entity in entities {
            requests.append(delete(entity: entity))
        }
        
        return Observable.zip(requests).mapToVoid()
    }

}


extension Array where Element: Persistable {
    func asDomain() -> [Element.DomainType] {
        return self.map { $0.asDomain() }
    }
}

extension Array where Element: DomainData {
    func asDatabaseType() -> [Element.DatabaseType] {
        return self.map { $0.asDatabaseType() }
    }
}
