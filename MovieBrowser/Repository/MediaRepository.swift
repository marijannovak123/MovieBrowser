//
//  MediaRepository.swift
//  MovieBrowser
//
//  Created by UHP Mac on 29/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import RxSwift

class MediaRepository {
    
    private let service: MediaService
    private let storage: MediaStorage
    
    init(service: MediaService, storage: MediaStorage) {
        self.service = service
        self.storage = storage
    }
    
    func getTrendingMovies(time: TimeWindow) -> Observable<[Movie]> {
        return service.getTrendingMovies(time: time)
    }
    
    func getTrendingShows(time: TimeWindow) -> Observable<[Show]> {
        return service.getTrendingShows(time: time)
    }
}
