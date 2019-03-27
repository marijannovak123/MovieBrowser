//
//  SingletonContainer.swift
//  MovieBrowser
//
//  Created by Marijan on 23/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Swinject
import RealmSwift
import Moya

class SingletonContainer {
    
    static func build() -> Container {
        let container = Container(defaultObjectScope: .container)
        
        // MARK: Singletons
        container.register(Realm.self) { _ in
            do {
                return try Realm()
            } catch {
                fatalError("Realm error: \(error)")
            }
        }
        
        container.register(DatabaseManager.self) {
            DatabaseManager(realm: $0.resolve(Realm.self)!)
        }
        
        container.register(UserDefaultsHelper.self) { _ in
            UserDefaultsHelper()
        }
        
        container.register(MoyaProvider<ApiEndpoint>.self) { _ in
            let loggerPlugin = NetworkLoggerPlugin(verbose: true)
            return MoyaProvider<ApiEndpoint>(plugins: [loggerPlugin])
        }
        
        container.register(ApiNetwork.self) {
            ApiNetwork(provider: $0.resolve(MoyaProvider<ApiEndpoint>.self)!)
        }
        
    
        // MARK: Services
        container.register(AuthService.self) {
            AuthService(api: $0.resolve(ApiNetwork.self)!)
        }
        
        container.register(MediaService.self) {
            MediaService(api: $0.resolve(ApiNetwork.self)!)
        }
        // MARK: Storages
        container.register(AuthStorage.self) {
            AuthStorage(dbManager: $0.resolve(DatabaseManager.self)!, defaults: $0.resolve(UserDefaultsHelper.self)!)
        }
        
        container.register(MediaStorage.self) {
            MediaStorage(dbManager: $0.resolve(DatabaseManager.self)!, defaults: $0.resolve(UserDefaultsHelper.self)!)
        }
        
        // MARK: Repositories
        container.register(AuthRepository.self) {
            AuthRepository(service: $0.resolve(AuthService.self)!, storage: $0.resolve(AuthStorage.self)!)
        }
        
        container.register(SyncRepository.self) {
            SyncRepository(service: $0.resolve(MediaService.self)!, storage: $0.resolve(MediaStorage.self)!)
        }
        
        return container
    }
}
