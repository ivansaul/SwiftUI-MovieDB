//
//  MockAccountDataService.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/19/24.
//
//  https://github.com/ivansaul
//

import Foundation

final class MockAccountDataService: AccountDataServiceProtocol {
    private let keychainManager: KeychainProtocol
    private let keySessionID: String = "KeySessionID"
    private let hasSessionID: Bool

    init(keychainManager: KeychainProtocol = MockKeychainManager(), hasSessionID: Bool = false) {
        self.keychainManager = keychainManager
        self.hasSessionID = hasSessionID

        if hasSessionID {
            keychainManager.set("mockSessionID", forKey: keySessionID)
        }
    }

    func fetchAccountDetails() async throws -> User? {
        guard keychainManager.get(key: keySessionID) != nil else {
            return nil
        }
        return User.preview
    }
}
