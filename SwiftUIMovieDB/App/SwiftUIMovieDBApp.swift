//
//  SwiftUIMovieDBApp.swift
//  SwiftUIMovieDB
//
//  Created by saul on 9/21/24.
//

import SwiftUI

@main
struct SwiftUIMovieDBApp: App {
    @State private var authViewModel: AuthViewModel = .init(
        authService: AuthService()
    )

    @State private var moviesViewModel: MoviesViewModel = .init(
        moviesDataService: MoviesDataService()
    )

    @State private var accountViewModel: AccountViewModel = .init(
        accountDataService: AccountDataService()
    )

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authViewModel)
                .environment(moviesViewModel)
                .environment(accountViewModel)
        }
    }
}
