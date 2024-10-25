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
    @Environment(AccountViewModel.self) private var accountViewModel

    @State private var selectedIndex: Int = 1

    var body: some View {
        ScrollView {
            VStack(spacing: 20.0) {
                header
                    .padding()

                carousel

                CategoriesFilterView(categories: .previewCategories)

                moviesListGroup
            }
        }
        .frame(maxWidth: .infinity)
        .scrollIndicators(.never)
        .background(Color.theme.primary.dark.ignoresSafeArea())
        .task { await accountViewModel.fetchAccountDetails() }
        .task { await moviesViewModel.fetchMovies() }
    }
}

#Preview {
    HomeView()
        .environment(MoviesViewModel.preview)
        .environment(AccountViewModel.preview)
}

extension HomeView {
    private var header: some View {
        let redact = accountViewModel.currentUser == nil
        let user: User = accountViewModel.currentUser ?? .preview
        return HomeHeaderView(user: user)
            .redacted(when: redact)
    }

    private var carousel: some View {
        HomeCarouselView(selectedIndex: $selectedIndex, movies: upcomingMovies)
            .redacted(when: isLoading)
    }

    private var moviesListGroup: some View {
        Group {
            MoviesListView(title: "Most popular", movies: popularMovies) {
                print("Most popular")
            }
            .redacted(when: isLoading)

            MoviesListView(title: "Now playing", movies: nowPlayingMovies) {
                print("Now playing")
            }
            .redacted(when: isLoading)

            MoviesListView(title: "Top rated", movies: topRatedMovies) {
                print("Top rated")
            }
            .redacted(when: isLoading)

            MoviesListView(title: "Upcoming", movies: upcomingMovies) {
                print("Upcoming")
            }
            .redacted(when: isLoading)
        }
    }
}

extension HomeView {
    private var nowPlayingMovies: [Movie] {
        moviesViewModel.nowPlayingMovies
    }

    private var popularMovies: [Movie] {
        moviesViewModel.popularMovies
    }

    private var topRatedMovies: [Movie] {
        moviesViewModel.topRatedMovies
    }

    private var upcomingMovies: [Movie] {
        moviesViewModel.upcomingMovies
    }

    private var isLoading: Bool {
        moviesViewModel.isLoading
    }
}
