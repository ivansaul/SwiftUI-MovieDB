//
//  AuthViewModel.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/18/24.
//
//  https://github.com/ivansaul
//

import Foundation

@Observable
class AuthViewModel {
    private(set) var isLoading: Bool = false
    private(set) var authStatus: AuthStatus = .checking
    private(set) var errorMessage: String = ""
    var showAlert: Bool = false
    private(set) var currentUser: User?

    @ObservationIgnored
    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol) {
        self.authService = authService
        Task { await checkAuthStatus() }
    }

    @MainActor
    func signIn() async {
        guard !isLoading else { return }
        defer { isLoading = false }

        isLoading = true

        do {
            try await authService.signInWithTMDB()
            await checkAuthStatus()
        } catch _ as AuthError {
            isLoading = false
            authStatus = .loggedOut
        } catch {
            loadError(error)
        }
    }

    @MainActor
    func signOut() async {
        guard !isLoading else { return }
        defer { isLoading = false }

        isLoading = true

        try? await authService.signOut()

        currentUser = nil
        authStatus = .loggedOut
    }

    @MainActor
    func fetchAccountDetails() async {
        guard !isLoading else { return }
        defer { isLoading = false }

        isLoading = true

        do {
            currentUser = try await authService.fetchAccountDetails()
        } catch {
            loadError(error)
        }
    }
}

extension AuthViewModel {
    @MainActor
    private func loadError(_ error: Error) {
        isLoading = false
        errorMessage = error.localizedDescription
        showAlert = true
    }

    @MainActor
    private func checkAuthStatus() async {
        authStatus = await authService.authStatus()
    }
}
