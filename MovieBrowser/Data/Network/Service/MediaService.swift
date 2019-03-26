//
//  MediaService.swift
//  MovieBrowser
//
//  Created by UHP Mac on 26/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import RxSwift

class MediaService: BaseService {
    
    func getTrending<T: Decodable>(type: MediaType, time: TimeWindow) -> Observable<T> {
        return api.request(target: .trending(type: type, time: time), responseType: T.self)
    }
    
}
