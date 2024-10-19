//
//  MockAuthService.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/18/24.
//
//  https://github.com/ivansaul
//

import Foundation

class MockAuthService: AuthServiceProtocol {
    private let keychainManager: KeychainProtocol
    private let keySessionID: String = "KeySessionID"

    var signInCalled = false
    var signOutCalled = false
    var shouldFailSignIn = false
    var error: Error?

    init(keychainManager: KeychainProtocol = MockKeychainManager()) {
        self.keychainManager = keychainManager
    }

    func signInWithTMDB() async throws {
        signInCalled = true
        if shouldFailSignIn {
            throw AuthError.denied
        }
        keychainManager.set("MocksessionID", forKey: keySessionID)
    }

    func fetchAccountDetails() async throws -> User? {
        guard keychainManager.get(key: keySessionID) != nil else {
            throw NetworkingError.badResponse
        }
        return User.preview
    }

    func signOut() async throws {
        signOutCalled = true
        keychainManager.delete(keySessionID)
    }

    func authStatus() async -> AuthStatus {
        keychainManager.get(key: keySessionID) == nil
            ? .loggedOut
            : .loggedIn
    }
}
