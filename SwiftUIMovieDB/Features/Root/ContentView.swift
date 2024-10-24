//
//  ContentView.swift
//  SwiftUIMovieDB
//
//  Created by saul on 9/21/24.
//
//  https://github.com/ivansaul

import SwiftUI

struct ContentView: View {
    @Environment(AuthViewModel.self) private var authViewModel
    var body: some View {
        NavigationStack {
            Group {
                switch authViewModel.authStatus {
                case .checking:
                    ProgressView()
                case .loggedIn:
                    HomeView()
                case .loggedOut:
                    LoginView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(AuthViewModel.preview)
        .environment(MoviesViewModel.preview)
        .environment(AccountViewModel.preview)
}
