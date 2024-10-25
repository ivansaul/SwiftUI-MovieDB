//
//  MoviesDataService.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 9/22/24.
//
//  https://github.com/ivansaul
//

import Foundation

protocol MoviesDataServiceProtocol {
    func fetchNowPlayingMovies() async throws -> [Movie]
    func fetchPopularMovies() async throws -> [Movie]
    func fetchTopRatedMovies() async throws -> [Movie]
    func fetchUpcomingMovies() async throws -> [Movie]
}
