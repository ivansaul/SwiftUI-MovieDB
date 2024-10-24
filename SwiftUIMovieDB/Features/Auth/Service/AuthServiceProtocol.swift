//
//  AuthServiceProtocol.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/18/24.
//
//  https://github.com/ivansaul
//

import Foundation

protocol AuthServiceProtocol {
    func signInWithTMDB() async throws
    func signOut() async throws
    func authStatus() async -> AuthStatus
}
