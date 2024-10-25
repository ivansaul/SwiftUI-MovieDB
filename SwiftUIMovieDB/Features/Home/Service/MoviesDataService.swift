//
//  MoviesDataServiceImpl.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 9/27/24.
//
//  https://github.com/ivansaul
//

import Foundation

class MoviesDataService: MoviesDataServiceProtocol, HTTPNetworking {
    func fetchNowPlayingMovies() async throws -> [Movie] {
        try await fetchMoviesList(path: APIConstants.MovieLists.nowPlaying)
    }

    func fetchPopularMovies() async throws -> [Movie] {
        try await fetchMoviesList(path: APIConstants.MovieLists.popular)
    }

    func fetchTopRatedMovies() async throws -> [Movie] {
        try await fetchMoviesList(path: APIConstants.MovieLists.topRated)
    }

    func fetchUpcomingMovies() async throws -> [Movie] {
        try await fetchMoviesList(path: APIConstants.MovieLists.upcoming)
    }

    private func fetchMoviesList(path: String) async throws -> [Movie] {
        let resource = MoviesListResource(path: path)
        let request = try resource.urlRequest()
        let data = try await fetchData(for: request)
        let wrapper = try decodeData(as: WrapperMovies.self, data: data)
        return wrapper.results
    }
}
