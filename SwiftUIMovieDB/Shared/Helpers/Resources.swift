//
//  Resources.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/27/24.
//
//  https://github.com/ivansaul
//

import Foundation

struct ImageResource: HTTPResource {
    let baseURL: String

    init(url: String) {
        self.baseURL = url
    }

    let path: String? = nil

    let method: HTTPMethod = .GET

    let headers: [String: String]? = nil

    let query: [String: Any]? = nil

    let body: [String: Any]? = nil
}
