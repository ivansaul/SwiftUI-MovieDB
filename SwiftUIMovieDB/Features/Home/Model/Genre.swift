//
//  Genre.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/27/24.
//
//  https://github.com/ivansaul
//

import Foundation

struct Genre: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
}

extension Genre {
    static var all: Self {
        Genre(id: 0, name: "All")
    }
}
