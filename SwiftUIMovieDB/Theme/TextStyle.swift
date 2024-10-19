//
//  TextStyle.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 9/21/24.
//
//  https://github.com/ivansaul
//

import Foundation
import SwiftUI

// Custom Fonts
/*
 Montserrat
 == MontserratRoman-Regular
 == Montserrat-Thin
 == MontserratRoman-ExtraLight
 == MontserratRoman-Light
 == MontserratRoman-Medium
 == MontserratRoman-SemiBold
 == MontserratRoman-Bold
 == MontserratRoman-ExtraBold
 == MontserratRoman-Black
 */

enum TypographyWeight {
    case regular
    case medium
    case semibold
}

extension Font {
    static func dlsFont(size: CGFloat, weight: TypographyWeight = .regular) -> Font {
        var fontName: String {
            switch weight {
            case .regular: return "MontserratRoman-Regular"
            case .medium: return "MontserratRoman-Medium"
            case .semibold: return "MontserratRoman-SemiBold"
            }
        }
        return Font.custom(fontName, size: size)
    }
}

enum TypographyStyle {
    // HEADING
    case h1(color: Color = .theme.text.white, weight: TypographyWeight = .regular)
    case h2(color: Color = .theme.text.white, weight: TypographyWeight = .regular)
    case h3(color: Color = .theme.text.white, weight: TypographyWeight = .regular)
    case h4(color: Color = .theme.text.white, weight: TypographyWeight = .regular)
    case h5(color: Color = .theme.text.white, weight: TypographyWeight = .regular)
    case h6(color: Color = .theme.text.white, weight: TypographyWeight = .regular)
    case h7(color: Color = .theme.text.white, weight: TypographyWeight = .regular)

    // PARAGRAPH
    case body(color: Color = .theme.text.white, weight: TypographyWeight = .regular)

    var size: CGFloat {
        switch self {
        case .h1: return 28
        case .h2: return 24
        case .h3: return 18
        case .h4: return 16
        case .h5: return 14
        case .h6: return 12
        case .h7: return 10
        case .body: return 12
        }
    }
}

private struct BaseTypography: ViewModifier {
    let type: TypographyStyle
    let weight: TypographyWeight
    let color: Color
    func body(content: Content) -> some View {
        content
            .font(.dlsFont(size: type.size, weight: weight))
            .foregroundStyle(color)
    }
}

extension View {
    /// Applies a custom typography style to a view
    ///
    /// Custom modifier to apply a custom typography style such as
    /// `headings`(h1 to h7) or `body` text.
    /// Each style has includes customizable color and font weight.
    /// For example:
    ///
    /// ```swift
    /// Text("Hello World!")
    ///     .textStyle(.h5(color: .theme.textWhite, weight: .regular))
    ///
    /// Text("Hello World!")
    ///     .textStyle(.body(color: .theme.textWhite, weight: .semibold))
    /// ```
    func textStyle(_ type: TypographyStyle) -> some View {
        switch type {
        case
            .h1(let color, let weight),
            .h2(let color, let weight),
            .h3(let color, let weight),
            .h4(let color, let weight),
            .h5(let color, let weight),
            .h6(let color, let weight),
            .h7(let color, let weight),
            .body(let color, let weight):
            return modifier(BaseTypography(type: type, weight: weight, color: color))
        }
    }
}
