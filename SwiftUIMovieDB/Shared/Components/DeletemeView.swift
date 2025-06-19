//
//  DeletemeView.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/26/24.
//
//  https://github.com/ivansaul
//

import SwiftUI

struct DeletemeView: View {
    @State private var change: Bool = false
    var body: some View {
        VStack {
            CachedImageView(url: change ? "https://i.imgur.com/4M07Gta.jpeg" : nil)
                .frame(width: 300, height: 300)

            Button("Change") {
                change.toggle()
            }
            .buttonStyle(.bordered)

            ExtractedView()
        }
    }
}

#Preview {
    DeletemeView()
}

struct ExtractedView: View {
    var body: some View {
        Text("HI")
    }
}
