//
//  AccountDetailsResource.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/18/24.
//
//  https://github.com/ivansaul
//

import Foundation

struct AccountDetailsResource: HTTPResource {
    private let sessionID: String
    
    init(sessionID: String) {
        self.sessionID = sessionID
    }

    let baseURL: String = APIConstants.apiBaseUrl
    
    var path: String? {
        APIConstants.Account.details
    }
    
    let method: HTTPMethod = .GET
    
    let headers: [String: String]? = [
        "accept": "application/json",
        "Authorization": "Bearer \(APIConstants.apiAccessToken)",
    ]
    
    var query: [String: Any]? {
        [
            "session_id": sessionID,
        ]
    }
    
    let body: [String: Any]? = nil
}
