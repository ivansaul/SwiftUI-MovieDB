//
//  MockKeychainManager.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/18/24.
//
//  https://github.com/ivansaul
//

import Foundation

class MockKeychainManager: KeychainProtocol {
    private var storage: [String: String] = [:]

    func set(_ value: String, forKey key: String) {
        storage[key] = value
    }

    func get(key: String) -> String? {
        return storage[key]
    }

    func delete(_ key: String) {
        storage.removeValue(forKey: key)
    }
}
