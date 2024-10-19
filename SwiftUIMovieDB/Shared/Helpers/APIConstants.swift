//
//  APIConstants.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/18/24.
//
//  https://github.com/ivansaul
//

import Foundation

enum APIConstants {
    static let apiBaseUrl = "https://api.themoviedb.org"
    static let apiImageBaseUrl = "https://image.tmdb.org/t/p"
    static let apiKey = API_KEY
    static let apiAccessToken = API_ACCESS_TOKEN
    static let movieDBUrlScheme = "MovieDBAuthScheme"
    static let movieDBUrl = "https://www.themoviedb.org"

    enum MovieLists {
        static let nowPlaying = "/3/movie/now_playing"
        static let popular = "/3/movie/popular"
    }

    enum Auth {
        static let authenticate = "/authenticate"
        static let requestToken = "/3/authentication/token/new"
        static let requestSessionId = "/3/authentication/session/new"
    }

    enum Account {
        static let details = "/3/account/account_id"
    }

    enum Keys {
        static let sessionID = "sessionIDKey"
    }
}
