//
//  DBShow.swift
//  MovieBrowser
//
//  Created by UHP Mac on 27/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Foundation

class DBShow: BaseModel, Persistable {
    
    @objc dynamic var episodeRunTime: [Int]?
    @objc dynamic var firstAirDate: String?
    @objc dynamic var genres: [DBGenre]?
    @objc dynamic var languages: [String]?
    @objc dynamic var lastAirDate: String?
    @objc dynamic var name: String?
    @objc dynamic var numberOfEpisodes = 0
    @objc dynamic var numberOfSeasons = 0
    @objc dynamic var originCountry: [String]?
    @objc dynamic var originalLanguage: String?
    @objc dynamic var originalName: String?
    @objc dynamic var overview: String?
    @objc dynamic var popularity = 0.0
    @objc dynamic var posterPath: String?
    @objc dynamic var status: String?
    @objc dynamic var type: String?
    @objc dynamic var voteAverage = 0.0
    @objc dynamic var voteCount = 0
    
    func asDomain() -> Show {
        return Show(id: self.id, episodeRunTime: self.episodeRunTime, firstAirDate: self.firstAirDate, genres: self.genres?.asDomain(), languages: self.languages, lastAirDate: self.lastAirDate, name: self.name, numberOfEpisodes: self.numberOfEpisodes, numberOfSeasons: self.numberOfSeasons, originCountry: self.originCountry, originalLanguage: self.originalLanguage, originalName: self.originalName, overview: self.overview, popularity: self.popularity, posterPath: self.posterPath, status: self.status, type: self.type, voteAverage: self.voteAverage, voteCount: self.voteCount)
    }
    
}
