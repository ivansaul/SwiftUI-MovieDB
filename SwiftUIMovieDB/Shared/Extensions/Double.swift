//
//  Double.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/24/24.
//
//  https://github.com/ivansaul
//

import Foundation

extension Double {
    /// Returns the double value formatted to a specified number of decimal places as a string.
    ///
    /// - Parameter decimals: The number of decimal places.
    /// - Returns: The formatted string.
    ///
    /// # Examples #
    /// ```
    /// let value: Double = 5142.888
    /// print(value.asNumberString(decimals: 2)) // Prints "5142.89"
    /// print(value.asNumberString(decimals: 3)) // Prints "5142.888"
    /// print(value.asNumberString(decimals: 4)) // Prints "5142.8880"
    /// ```
    func asNumberString(decimals: Int = 1) -> String {
        return String(format: "%.\(decimals)f", self)
    }
}
