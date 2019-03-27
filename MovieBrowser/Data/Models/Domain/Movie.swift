//
//  Movie.swift
//  MovieBrowser
//
//  Created by UHP Mac on 27/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Foundation

struct Movie: DomainData {
    
    let id: Int
    let adult: Bool?
    let budget: Int?
    let genres: [Genre]?
    let imdbID: String?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let revenue, runtime: Int?
    let status, tagline, title: String?
    let voteAverage: Double?
    let voteCount: Int?
    
    var uid: Int {
        return id
    }
    
    func asDatabaseType() -> DBMovie {
        let dbMovie = DBMovie()
        dbMovie.id = self.id
        dbMovie.adult = self.adult ?? false
        dbMovie.budget = self.budget ?? 0
        dbMovie.genres = self.genres?.asDatabaseType() ?? []
        dbMovie.imdbID = self.imdbID
        dbMovie.originalLanguage = self.originalLanguage
        dbMovie.originalTitle = self.originalTitle
        dbMovie.overview = self.overview
        dbMovie.popularity = self.popularity ?? 0.0
        dbMovie.posterPath = self.posterPath
        dbMovie.releaseDate = self.releaseDate
        dbMovie.revenue = self.revenue ?? 0
        dbMovie.runtime = self.runtime ?? 0
        dbMovie.status = self.status
        dbMovie.tagline = self.tagline
        dbMovie.title = self.title
        dbMovie.voteAverage = self.voteAverage ?? 0.0
        dbMovie.voteCount = self.voteCount ?? 0
        return dbMovie
    }

}
