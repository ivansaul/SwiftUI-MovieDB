//
//  AccountDataServiceProtocol.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/19/24.
//
//  https://github.com/ivansaul
//

import Foundation

protocol AccountDataServiceProtocol {
    func fetchAccountDetails() async throws -> User?
}
