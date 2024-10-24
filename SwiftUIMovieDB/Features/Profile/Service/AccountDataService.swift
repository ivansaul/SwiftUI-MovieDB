//
//  AccountDataService.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/19/24.
//
//  https://github.com/ivansaul
//

import Foundation

final class AccountDataService: AccountDataServiceProtocol, HTTPNetworking {
    private let keychainManager: KeychainProtocol = KeychainManager()

    func fetchAccountDetails() async throws -> User? {
        guard let sessionID = keychainManager.get(key: APIConstants.Keys.sessionID) else {
            return nil
        }
        let resource = AccountDetailsResource(sessionID: sessionID)
        let request = try resource.urlRequest()
        let data = try await fetchData(for: request)
        return try decodeData(as: User.self, data: data)
    }
}
