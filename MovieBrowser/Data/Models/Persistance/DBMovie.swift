//
//  DBMovie.swift
//  MovieBrowser
//
//  Created by UHP Mac on 27/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Realm
import RealmSwift

class DBMovie: BaseModel, Persistable {
    
    @objc dynamic var adult = false
    @objc dynamic var budget = 0
    @objc dynamic var imdbID: String?
    @objc dynamic var originalLanguage: String?
    @objc dynamic var originalTitle: String?
    @objc dynamic var overview: String?
    @objc dynamic var popularity = 0.0
    @objc dynamic var posterPath: String?
    @objc dynamic var releaseDate: String?
    @objc dynamic var revenue = 0
    @objc dynamic var runtime = 0
    @objc dynamic var status: String?
    @objc dynamic var tagline: String?
    @objc dynamic var title: String?
    @objc dynamic var voteAverage = 0.0
    @objc dynamic var voteCount = 0
    var genres = [DBGenre]()
    
    func asDomain() -> Movie {
        return Movie(id: self.id, adult: self.adult, budget: self.budget, genres: self.genres.asDomain(), imdbID: self.imdbID, originalLanguage: self.originalLanguage, originalTitle: self.originalTitle, overview: self.overview, popularity: self.popularity, posterPath: self.posterPath, releaseDate: self.releaseDate, revenue: self.revenue, runtime: self.runtime, status: self.status, tagline: self.tagline, title: self.title, voteAverage: self.voteAverage, voteCount: self.voteCount)
    }
    
}
