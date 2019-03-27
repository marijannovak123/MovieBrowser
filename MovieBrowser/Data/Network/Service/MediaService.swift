//
//  MediaService.swift
//  MovieBrowser
//
//  Created by UHP Mac on 26/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import RxSwift

class MediaService: BaseService {
    
    func getTrendingMovies(time: TimeWindow) -> Observable<[Movie]> {
        return api.request(target: .trending(type: .movie, time: time), responseType: [Movie].self)
    }
    
    func getTrendingShows(time: TimeWindow) -> Observable<[Show]> {
        return api.request(target: .trending(type: .tv, time: time), responseType: [Show].self)
    }
    
    func getGenres(type: MediaType) -> Observable<[Genre]> {
        return api.request(target: .genres(type: type), responseType: GenresResponse.self)
            .map { $0.genres }
    }
}
