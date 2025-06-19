//
//  WrapperResults.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 9/23/24.
//
//  https://github.com/ivansaul
//

import Foundation

struct WrapperResults<T: Decodable>: Decodable {
    let results: [T]
}

struct WrapperGenres<T: Decodable>: Decodable {
    let genres: [T]
}


typealias WrapperMovies = WrapperResults<Movie>
