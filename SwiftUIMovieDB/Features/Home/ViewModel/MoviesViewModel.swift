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

    private let dataService: MoviesDataService

    init(dataService: MoviesDataService) {
        self.dataService = dataService
    }

    @MainActor
    func fetchMovies() async {
        guard !isLoading else { return }
        defer { isLoading = false }

        isLoading = true
        do {
            movies = try await dataService.fetchMovies()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
