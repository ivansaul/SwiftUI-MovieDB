//
//  HomeView.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 9/21/24.
//
//  https://github.com/ivansaul
//

import SwiftUI

struct HomeView: View {
    @Environment(MoviesViewModel.self) private var moviesViewModel

    var body: some View {
        List(moviesViewModel.movies) { movie in
            Text(movie.title)
        }
        .task { await moviesViewModel.fetchMovies() }
    }
}

#Preview {
    HomeView()
        .environment(MoviesViewModel(dataService: MockMoviesDataService()))
}
