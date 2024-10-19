//
//  MoviesDataService.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 9/22/24.
//
//  https://github.com/ivansaul
//

import Foundation

protocol MoviesDataService {
    func fetchMovies() async throws -> [Movie]
}
