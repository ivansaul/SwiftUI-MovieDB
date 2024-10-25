//
//  MoviesListView.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/25/24.
//
//  https://github.com/ivansaul
//

import SwiftUI

struct MoviesListView: View {
    let title: String
    let movies: [Movie]
    let onSeeAll: () -> Void

    init(title: String, movies: [Movie], onSeeAll: @escaping () -> Void) {
        self.title = title
        self.movies = movies
        self.onSeeAll = onSeeAll
    }

    var body: some View {
        VStack(spacing: 15.0) {
            HStack {
                Text(title)
                    .textStyle(.h4(color: .theme.text.white, weight: .semibold))
                Spacer()

                Button(action: onSeeAll, label: {
                    Text("See All")
                        .textStyle(.h5(color: .blue, weight: .medium))
                })
            }
            .padding(.horizontal)

            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(movies) { movie in
                        MovieCardView(movie: movie)
                            .padding(.leading)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    MoviesListView(title: "Now playing", movies: .preview, onSeeAll: {})
}
