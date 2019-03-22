//
//  ApiEndpoint.swift
//  MovieBrowser
//
//  Created by UHP Mac on 22/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Moya

enum ApiEndpoint {
    case newToken
    case login(request: LoginRequest)
}

extension ApiEndpoint: TargetType {
 
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    var path: String {
        switch self {
        case .newToken:
            return "authentication/token/new"
        case .login:
            return "authentication/token/validate_with_login"
        }
    }
    
    var method: Method {
        switch self {
        case .login:
            return .post
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login(let request):
            return .requestCompositeData(bodyData: encodeLoginRequest(request), urlParameters: parameters)
        default:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var parameters: [String : Any] {
        return ["api_key": Constants.apiKey]
    }
    
    var headers: [String : String]? {
        return nil
    }

    private func encodeLoginRequest(_ request: LoginRequest) -> Data {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return try! encoder.encode(request)
    }
}
