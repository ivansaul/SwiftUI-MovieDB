//
//  PreviewData.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 9/21/24.
//
//  https://github.com/ivansaul
//

import Foundation

extension [Movie] {
    static var preview: [Movie] {
        let data = MockData.popularMovies.data
        let wrapper = try! JSONDecoder().decode(WrapperMovies.self, from: data)
        return wrapper.results
    }
}

extension Movie {
    static var preview: Self {
        [Movie].preview.first!
    }
}
