//
//  ProfileViewModel.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/19/24.
//
//  https://github.com/ivansaul
//

import Foundation

@Observable
final class AccountViewModel {
    private(set) var isLoading: Bool = false
    private(set) var errorMessage: String = ""
    private(set) var currentUser: User?
    var showAlert: Bool = false

    private let accountDataService: AccountDataServiceProtocol

    init(accountDataService: AccountDataServiceProtocol) {
        self.accountDataService = accountDataService
    }

    @MainActor
    func fetchAccountDetails() async {
        guard !isLoading else { return }
        defer { isLoading = false }

        isLoading = true

        do {
            currentUser = try await accountDataService.fetchAccountDetails()
        } catch {
            loadError(error)
        }
    }
}

extension AccountViewModel {
    @MainActor
    private func loadError(_ error: Error) {
        isLoading = false
        errorMessage = error.localizedDescription
        showAlert = true
    }
}
