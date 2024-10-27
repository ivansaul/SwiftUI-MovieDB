//
//  MovieCardView.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/24/24.
//
//  https://github.com/ivansaul
//

import SwiftUI

struct MovieCardView: View {
    let movie: Movie

    var body: some View {
        VStack {
            CachedImageView(url: movie.posterUrl)
                .frame(maxWidth: .infinity)
                .frame(height: 178)

            VStack(alignment: .leading) {
                Text(movie.title)
                    .textStyle(.h5(color: .theme.text.white, weight: .semibold))
                    .lineLimit(1)

                Text("Action")
                    .textStyle(.h7(color: .theme.text.grey, weight: .medium))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
        }
        .frame(width: 135)
        .background(Color.theme.primary.soft)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(alignment: .topTrailing) {
            RateView(rate: movie.voteAverage)
                .padding(8)
        }
    }
}

#Preview {
    MovieCardView(movie: Movie.preview)
}
