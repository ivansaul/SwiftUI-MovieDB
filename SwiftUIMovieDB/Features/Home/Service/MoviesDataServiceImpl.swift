//
//  MoviesDataServiceImpl.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 9/27/24.
//
//  https://github.com/ivansaul
//

import Foundation

class MoviesDataServiceImpl: MoviesDataService, HTTPNetworking {
    func fetchMovies() async throws -> [Movie] {
        let resource = MoviesResource()
        let request = try resource.urlRequest()
        let data = try await fetchData(for: request)
        let wrapper = try decodeData(as: WrapperMovies.self, data: data)
        return wrapper.results
    }
}
