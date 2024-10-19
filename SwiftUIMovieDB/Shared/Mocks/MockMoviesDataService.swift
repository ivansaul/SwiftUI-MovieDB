//
//  MockMoviesDataService.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 9/28/24.
//
//  https://github.com/ivansaul
//

import Foundation

class MockMoviesDataService: MoviesDataService {
    func fetchMovies() async throws -> [Movie] {
        [Movie].preview
    }
}
