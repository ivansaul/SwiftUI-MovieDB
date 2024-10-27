//
//  HomeCarouselView.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/24/24.
//
//  https://github.com/ivansaul
//

import SwiftUI

struct HomeCarouselView: View {
    @Binding var selectedIndex: Int
    let movies: [Movie]
    var body: some View {
        VStack(spacing: 15.0) {
            CarouselView(items: movies, autoplay: true, selectedIndex: $selectedIndex) { movie in
                ZStack(alignment: .bottom) {
                    CachedImageView(url: movie.backdropUrl)
                    VStack(alignment: .leading, spacing: 5) {
                        Text(movie.title)
                            .textStyle(.h3(color: .theme.text.white, weight: .semibold))
                        if let releaseDate = movie.releaseDate.toFormattedDateString() {
                            Text(releaseDate)
                                .textStyle(.h6(color: .theme.text.white, weight: .medium))
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.black.opacity(0.6),
                                Color.black.opacity(0.3),
                                Color.black.opacity(0.0)
                            ]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .frame(height: 200)

            DotsIndicatorView(selectedIndex: $selectedIndex, dotsCount: movies.count)
        }
    }
}

#Preview {
    HomeCarouselView(selectedIndex: .constant(1), movies: [Movie].preview)
}
