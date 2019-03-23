//
//  BaseService.swift
//  Autism Helper iOS
//
//  Created by UHP Digital Mac 3 on 12.02.19.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxSwift

class BaseService {
    
    let api: ApiNetwork
    
    init(api: ApiNetwork) {
        self.api = api
    }

}
