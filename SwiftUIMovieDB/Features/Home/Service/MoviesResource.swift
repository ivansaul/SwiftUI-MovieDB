//
//  MoviesResource.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 9/23/24.
//
//  https://github.com/ivansaul
//

import Foundation

struct MoviesListResource: HTTPResource {
    let baseURL: String = APIConstants.apiBaseUrl

    let path: String?

    let method: HTTPMethod = .GET

    let headers: [String: String]? = [
        "accept": "application/json",
        "Authorization": "Bearer \(APIConstants.apiAccessToken)",
    ]

    let query: [String: Any]? = nil

    let body: [String: Any]? = nil
}
