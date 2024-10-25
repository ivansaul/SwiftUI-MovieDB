//
//  View.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/25/24.
//
//  https://github.com/ivansaul
//

import SwiftUI

extension View {
    @ViewBuilder
    func redacted(when condition: @autoclosure () -> Bool) -> some View {
        redacted(reason: condition() ? .placeholder : [])
    }
}
