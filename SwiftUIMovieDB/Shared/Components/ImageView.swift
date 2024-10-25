//
//  ImageView.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/22/24.
//
//  https://github.com/ivansaul
//

import SwiftUI

struct ImageView: View {
    let url: String?
    var debug: Bool = false
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay {
                ImageLoader(url: url, debug: debug)
            }
            .clipped()
    }
}

#Preview {
    ImageView(url: Movie.preview.posterUrl, debug: true)
        .frame(width: 200, height: 200)
}

private struct ImageLoader: View {
    let url: String?
    var debug: Bool = false

    let backgroundColor = Color.theme.primary.blueAccent.opacity(0.3)

    var body: some View {
        buildImage()
    }

    @ViewBuilder
    private func buildImage() -> some View {
        if debug {
            Image(.movieBackdrop)
                .resizable()
                .scaledToFill()
        } else if let url {
            AsyncImage(url: URL(string: url)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Rectangle()
                    .fill(backgroundColor)
                    .overlay {
                        ProgressView()
                    }
            }
        } else {
            Image(systemName: "photo.on.rectangle.angled")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(backgroundColor)
        }
    }
}
