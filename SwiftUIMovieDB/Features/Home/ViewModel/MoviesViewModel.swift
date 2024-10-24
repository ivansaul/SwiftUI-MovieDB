//
//  MoviesViewModel.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 9/27/24.
//
//  https://github.com/ivansaul
//

import Foundation

@Observable
class MoviesViewModel {
    private(set) var movies: [Movie] = []
    private(set) var errorMessage: String = ""
    private(set) var isLoading: Bool = false

    private let moviesDataService: MoviesDataServiceProtocol

    init(moviesDataService: MoviesDataServiceProtocol) {
        self.moviesDataService = moviesDataService
    }

    @MainActor
    func fetchMovies() async {
        guard !isLoading else { return }
        defer { isLoading = false }

        isLoading = true
        do {
            movies = try await moviesDataService.fetchMovies()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
