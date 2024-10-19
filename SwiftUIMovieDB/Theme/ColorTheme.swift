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
    let primary = PrimaryColors()
    let secondary = SecondaryColors()
    let text = TextColors()

    struct PrimaryColors {
        let blueAccent = Color("PrimaryColorBlueAccent")
        let dark = Color("PrimaryColorDark")
        let soft = Color("PrimaryColorSoft")
    }

    struct SecondaryColors {
        let green = Color("SecondaryColorGreen")
        let orange = Color("SecondaryColorOrange")
        let red = Color("SecondaryColorRed")
    }

    struct TextColors {
        let black = Color("TextColorBlack")
        let darkGrey = Color("TextColorDarkGrey")
        let grey = Color("TextColorGrey")
        let lineDark = Color("TextColorLineDark")
        let white = Color("TextColorWhite")
        let whiteGrey = Color("TextColorWhiteGrey")
    }
}
