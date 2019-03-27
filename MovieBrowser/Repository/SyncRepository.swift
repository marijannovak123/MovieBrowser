//
//  ContentSyncRepository.swift
//  MovieBrowser
//
//  Created by UHP Mac on 27/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import RxSwift

class SyncRepository {
    
    private let service: MediaService
    private let storage: MediaStorage
    
    init(service: MediaService, storage: MediaStorage) {
        self.service = service
        self.storage = storage
    }
    
    func fetchAndSaveLocalContent() -> Observable<Void> {
        return Observable.zip (
            service.getGenres(type: .movie),
            service.getGenres(type: .tv)
        ) { $0 + $1 }
        .flatMap { allGenres in
           self.storage.saveGenres(allGenres)
        }
    }
}
