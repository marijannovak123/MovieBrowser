//
//  DatabaseManager.swift
//  MovieBrowser
//
//  Created by Marijan on 23/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

class DatabaseManager {
    
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func allObjects<T: DomainData>(oftype type: T.Type) -> Observable<[T]> where T.DatabaseType.DomainType == T {
        let objects = realm.objects(type.DatabaseType.self)
        return Observable.array(from: objects).map { $0.map { $0.asDomain()} }
    }
    
    func objectsForValue<T: DomainData>(ofType type: T.Type, fieldName: String, fieldValue: CVarArg) -> Observable<[T]> where T.DatabaseType.DomainType == T {
        let predicate = NSPredicate(format: "\(fieldName) = %@", fieldValue)
        let objects = realm.objects(type.DatabaseType.self).filter(predicate)
        return Observable.array(from: objects).map { $0.asDomain() }
    }
    
    func singleObject<T: DomainData>(ofType type: T.Type, id: String) -> Observable<T?> where T.DatabaseType.DomainType == T {
        if let object = realm.object(ofType: type.DatabaseType.self, forPrimaryKey: id) {
            return Observable.from(object: object).map { $0.asDomain() }
        } else {
            return Observable.just(nil)
        }
    }
    
    func deleteObject<T: DomainData>(object: T) -> Observable<Void> {
        return realm.rx.delete(entity: object)
    }
    
    func deleteMultiple<T: DomainData>(objects: [T]) -> Observable<Void> {
        return realm.rx.deleteMultiple(entities: objects)
    }
    
    func deleteAll<T: DomainData>(type: T.Type) -> Observable<Void> where T.DatabaseType.DomainType == T {
        let objects = realm.objects(type.DatabaseType.self).toArray()
        return self.deleteMultiple(objects: objects.asDomain())
    }
    
    func saveObject<T: DomainData>(object: T) -> Observable<Void> {
        return realm.rx.save(entity: object)
    }
    
    func saveMultiple<T: DomainData>(objects: [T]) -> Observable<Void> {
        return realm.rx.saveMultiple(entities: objects)
    }
}
