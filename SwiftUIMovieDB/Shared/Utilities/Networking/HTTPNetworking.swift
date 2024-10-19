//
//  HTTPNetworking.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 9/27/24.
//
//  https://github.com/ivansaul
//

import Foundation

protocol HTTPNetworking {
    func fetchData(for request: URLRequest) async throws -> Data
    func decodeData<T: Decodable>(as type: T.Type, data: Data) throws -> T
}

extension HTTPNetworking {
    func fetchData(for request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let response = response as? HTTPURLResponse else {
            throw NetworkingError.badResponse
        }

        guard response.statusCode == 200 else {
            throw NetworkingError.requestFailed(response.statusCode)
        }

        return data
    }

    func decodeData<T: Decodable>(as type: T.Type, data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw NetworkingError.decodingFailed
        }
    }
}
