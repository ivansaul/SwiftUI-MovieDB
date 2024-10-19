//
//  AuthResources.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/18/24.
//
//  https://github.com/ivansaul
//

import Foundation

struct AuthResource: HTTPResource {
    let baseURL: String = APIConstants.apiBaseUrl
    
    let path: String? = APIConstants.Auth.requestToken
    
    let method: HTTPMethod = .GET
    
    let headers: [String: String]? = [
        "accept": "application/json",
        "Authorization": "Bearer \(APIConstants.apiAccessToken)",
    ]
    
    let query: [String: Any]? = nil
    
    let body: [String: Any]? = nil
}

struct AuthSessionIDResource: HTTPResource {
    private let requestToken: String
    
    init(requestToken: String) {
        self.requestToken = requestToken
    }
    
    let baseURL: String = APIConstants.apiBaseUrl
    
    let path: String? = APIConstants.Auth.requestSessionId
    
    let method: HTTPMethod = .POST
    
    let headers: [String: String]? = [
        "accept": "application/json",
        "content-type": "application/json",
        "Authorization": "Bearer \(APIConstants.apiAccessToken)",
    ]
    
    let query: [String: Any]? = nil
    
    var body: [String: Any]? {
        [
            "request_token": requestToken,
        ]
    }
}
