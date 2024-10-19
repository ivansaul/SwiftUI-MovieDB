//
//  KeychainManager.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/18/24.
//
//  https://github.com/ivansaul
//

import Foundation

import KeychainSwift

protocol KeychainProtocol {
    func get(key: String) -> String?
    func set(_ value: String, forKey: String)
    func delete(_ key: String)
}

class KeychainManager: KeychainProtocol {
    private let keychain = KeychainSwift()

    func get(key: String) -> String? {
        keychain.get(key)
    }

    func set(_ value: String, forKey: String) {
        keychain.set(value, forKey: forKey)
    }

    func delete(_ key: String) {
        keychain.delete(key)
    }
}
