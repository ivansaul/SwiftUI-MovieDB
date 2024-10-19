//
//  HTTPResource.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 9/23/24.
//
//  https://github.com/ivansaul
//

import Foundation

protocol HTTPResource {
    var baseURL: String { get }
    var path: String? { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var query: [String: Any]? { get }
    var body: [String: Any]? { get }
}

extension HTTPResource {
    func urlRequest() throws -> URLRequest {
        guard var url = URL(string: baseURL) else {
            throw NetworkingError.badURL
        }

        if let path {
            url = url.appending(path: path)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        if let query {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = query.map { URLQueryItem(name: $0, value: "\($1)") }
            request.url = components?.url
        }

        guard method != .GET else {
            return request
        }

        guard let body else {
            throw NetworkingError.missingBody
        }

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            throw NetworkingError.encodingFailed
        }
        return request
    }
}
