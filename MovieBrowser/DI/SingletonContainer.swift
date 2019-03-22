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
        
        container.register(MoyaProvider<ApiEndpoint>.self) { _ in
            let loggerPlugin = NetworkLoggerPlugin(verbose: true)
            return MoyaProvider<ApiEndpoint>(plugins: [loggerPlugin])
        }
        
        container.register(ApiNetwork.self) {
            ApiNetwork(provider: $0.resolve(MoyaProvider<ApiEndpoint>.self)!)
        }
        
    
        // MARK: Services
      
        // MARK: Storages
   
        // MARK: Repositories
       
        return container
    }
}
