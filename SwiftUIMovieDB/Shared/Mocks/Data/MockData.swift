//
//  MockData.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 9/26/24.
//
//  https://github.com/ivansaul
//

import Foundation

enum MockData {
    case popularMovies
    case accountDetails
    case genresMovie

    var data: Data {
        switch self {
        case .popularMovies:
            return loadJson("Popular_Movies")
        case .accountDetails:
            return loadJson("Account_Details")
        case .genresMovie:
            return loadJson("Genres_Movie")
        }
    }
}

extension MockData {
    private func loadJson(_ name: String) -> Data {
        let data = Bundle.main.url(forResource: name, withExtension: "json")!
        return try! Data(contentsOf: data)
    }
}
