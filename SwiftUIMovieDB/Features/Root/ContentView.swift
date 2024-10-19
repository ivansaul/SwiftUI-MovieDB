//
//  ContentView.swift
//  SwiftUIMovieDB
//
//  Created by saul on 9/21/24.
//
//  https://github.com/ivansaul

import SwiftUI

struct ContentView: View {
    @State private var moviesViewModel = MoviesViewModel(
        dataService: MoviesDataServiceImpl()
    )

    var body: some View {
        HomeView()
            .environment(moviesViewModel)
    }
}

#Preview {
    ContentView()
}
