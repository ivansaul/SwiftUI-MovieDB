//
//  NetworkError.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 9/23/24.
//
//  https://github.com/ivansaul
//

import Foundation

enum NetworkingError: Error, LocalizedError {
    case badURL
    case badResponse
    case decodingFailed
    case encodingFailed
    case missingBody
    case requestFailed(_ statusCode: Int)
    case unknownError
}

extension NetworkingError {
    var errorDescription: String {
        switch self {
        case .badURL:
            return "The URL provided is not valid."
        case .badResponse:
            return "We received an unexpected response from the server."
        case .decodingFailed:
            return "We couldn't process the data from the server."
        case .encodingFailed:
            return "There was an issue preparing the data to send."
        case .missingBody:
            return "The request is missing necessary information to proceed."
        case .requestFailed(let statusCode):
            return "There was an issue with the request. Please try again later. [\(statusCode)]"
        case .unknownError:
            return "Something went wrong. Please try again."
        }
    }
}
