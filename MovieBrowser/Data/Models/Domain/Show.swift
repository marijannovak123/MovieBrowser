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
    let languages: [String]?
    let lastAirDate: String?
    let name: String?
    let numberOfEpisodes: Int?
    let numberOfSeasons: Int?
    let originCountry: [String]?
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
        return dbShow
    }
    
}
