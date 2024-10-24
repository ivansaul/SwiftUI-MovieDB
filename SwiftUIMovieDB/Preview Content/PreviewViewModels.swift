//
//  PreviewViewModels.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/19/24.
//
//  https://github.com/ivansaul
//

import Foundation

extension AccountViewModel {
    static let preview: AccountViewModel = .init(
        accountDataService: MockAccountDataService(hasSessionID: true)
    )
}

extension AuthViewModel {
    static let preview: AuthViewModel = .init(
        authService: MockAuthService()
    )
}

extension MoviesViewModel {
    static let preview: MoviesViewModel = .init(
        moviesDataService: MockMoviesDataService()
    )
}
