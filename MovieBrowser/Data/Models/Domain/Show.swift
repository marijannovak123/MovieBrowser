//
//  Show.swift
//  MovieBrowser
//
//  Created by UHP Mac on 27/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Foundation

struct Show: DomainData {
   
    let id: Int
    let episodeRunTime: [Int]?
    let firstAirDate: String?
    let genres: [Genre]?
    let lastAirDate: String?
    let name: String?
    let numberOfEpisodes: Int?
    let numberOfSeasons: Int?
    let originalLanguage: String?
    let originalName: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let status: String?
    let type: String?
    let voteAverage: Double?
    let voteCount: Int?
    
    var uid: Int {
        return id
    }
    
    func asDatabaseType() -> DBShow {
        let dbShow = DBShow()
        dbShow.id = self.id
        dbShow.episodeRunTime = self.episodeRunTime ?? []
        dbShow.firstAirDate = self.firstAirDate
        dbShow.genres = self.genres?.asDatabaseType() ?? []
        dbShow.lastAirDate = self.lastAirDate
        dbShow.name = self.name
        dbShow.numberOfEpisodes = self.numberOfEpisodes ?? 0
        dbShow.numberOfSeasons = self.numberOfSeasons ?? 0
        dbShow.originalLanguage =  self.originalLanguage
        dbShow.originalName = self.originalName
        dbShow.overview = self.overview
        dbShow.popularity = self.popularity ?? 0.0
        dbShow.posterPath = self.posterPath
        dbShow.status = self.status
        dbShow.type = self.type
        dbShow.voteAverage = self.voteAverage ?? 0.0
        dbShow.voteCount = self.voteCount ?? 0
        return dbShow
    }
    
}
