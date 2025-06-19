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
    private(set) var nowPlayingMovies: [Movie] = []
    private(set) var popularMovies: [Movie] = []
    private(set) var topRatedMovies: [Movie] = []
    private(set) var upcomingMovies: [Movie] = []
    private(set) var genresMovie: [Genre] = [.all]
    private(set) var selectedGenre: Genre = .all
    private(set) var errorMessage: String = ""
    private(set) var isLoading: Bool = false

    private let moviesDataService: MoviesDataServiceProtocol

    init(moviesDataService: MoviesDataServiceProtocol) {
        self.moviesDataService = moviesDataService

        // Prepare placeholder data
        setPlaceholderData()
    }

    @MainActor
    func fetchMovies() async {
        guard !isLoading else { return }
        defer { isLoading = false }

        isLoading = true
        do {
            (nowPlayingMovies, popularMovies, topRatedMovies, upcomingMovies) = try await (
                moviesDataService.fetchNowPlayingMovies(),
                moviesDataService.fetchPopularMovies(),
                moviesDataService.fetchTopRatedMovies(),
                moviesDataService.fetchUpcomingMovies()
            )

        } catch {
            errorMessage = error.localizedDescription
        }
    }

    @MainActor
    func fetchGenresMovie() async {
//        guard !isLoading else { return }
        defer { isLoading = false }

        isLoading = true
        do {
            print("DEBUG: genres ...")
            genresMovie += .preview

        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

extension MoviesViewModel {
    private func setPlaceholderData() {
        nowPlayingMovies = .preview
        popularMovies = .preview
        topRatedMovies = .preview
        upcomingMovies = .preview
    }
}
