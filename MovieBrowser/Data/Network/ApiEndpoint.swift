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
    case createSession(requestToken: String)
    case genres(type: MediaType)
    case trending(type: MediaType, time: TimeWindow)
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
        case .createSession:
            return "authentication/session/new"
        case .genres(let type):
            return "genre/\(type.rawValue)/list"
        case .trending(let type, let time):
            return "trending/\(type.rawValue)/\(time.rawValue)"
        }
    }
    
    var method: Method {
        switch self {
        case .login, .createSession:
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
            return .requestCompositeParameters(bodyParameters: encodeRequest(request), bodyEncoding: JSONEncoding.default, urlParameters: authParameters)
        case .createSession(let token):
            return .requestCompositeParameters(bodyParameters: ["request_token": token], bodyEncoding: JSONEncoding.default, urlParameters: authParameters)
        default:
            return .requestParameters(parameters: authParameters, encoding: URLEncoding.default)
        }
    }
    
    var authParameters: [String : Any] {
        return ["api_key": Constants.apiKey]
    }
    
    var accParameters: [String: Any] {
        return ["api_key": Constants.apiKey, "session_id": sessionId]
    }
    
    var headers: [String : String]? {
        return nil
    }

    private func encodeRequest<T: Encodable>(_ request: T) -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try! encoder.encode(request)
        return try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    }
    
    private var sessionId: String {
        let defaults = AppDelegate.instance.singletonContainer.resolve(UserDefaultsHelper.self)!
        return defaults.sessionId
    }
    
}
