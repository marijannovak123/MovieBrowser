//
//  MediaStorage.swift
//  MovieBrowser
//
//  Created by UHP Mac on 26/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import RxSwift

class MediaStorage: BaseStorage {

    func saveGenres(_ genres: [Genre]) -> Observable<Void> {
        return databaseManager.saveMultiple(objects: genres)
    }
}
