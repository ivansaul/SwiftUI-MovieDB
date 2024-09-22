//
//  ColorTheme.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 9/21/24.
//
//  https://github.com/ivansaul
//

import Foundation

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    // PRIMARY COLORS
    let primaryBlueAccent = Color("PrimaryColorBlueAccent")
    let primaryDark = Color("PrimaryColorDark")
    let primarySoft = Color("PrimaryColorSoft")

    // SECONDARY COLORS
    let secondaryGreen = Color("secondaryColorGreen")
    let secondaryOrange = Color("secondaryColorOrange")
    let secondaryRed = Color("secondaryColorRed")

    // TEXT COLORS
    let textBlack = Color("TextColorBlack")
    let textDarkGrey = Color("TextColorDarkGrey")
    let textGrey = Color("TextColorGrey")
    let textLineDark = Color("TextColorLineDark")
    let textWhite = Color("TextColorWhite")
    let textWhiteGrey = Color("TextColorWhiteGrey")
}
