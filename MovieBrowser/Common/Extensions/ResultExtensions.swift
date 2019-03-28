//
//  ResultExtensions.swift
//  MovieBrowser
//
//  Created by UHP Mac on 28/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Moya

extension Result {
    
    func toUIResult() -> UIResult<Success> {
        switch self {
        case .success(let data):
            return UIResult.success(data)
        case .failure(let error):
            if let resolvedError = error as? MoyaError {
                let networkError = NetworkError(resolvedError)
                return UIResult.error(networkError.errorMessage)
            } else {
                return UIResult.error(error.localizedDescription)
            }
        }
    }
}
