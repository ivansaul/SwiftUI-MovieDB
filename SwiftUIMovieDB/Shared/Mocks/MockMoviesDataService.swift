//
//  MockMoviesDataService.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 9/28/24.
//
//  https://github.com/ivansaul
//

import Foundation

class MockMoviesDataService: MoviesDataServiceProtocol {
    func fetchNowPlayingMovies() async throws -> [Movie] {
        .preview
    }

    func fetchPopularMovies() async throws -> [Movie] {
        .preview
    }

    func fetchTopRatedMovies() async throws -> [Movie] {
        .preview
    }

    func fetchUpcomingMovies() async throws -> [Movie] {
        .preview
    }
}
