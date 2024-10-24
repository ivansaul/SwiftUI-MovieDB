//
//  String.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/24/24.
//
//  https://github.com/ivansaul
//

import Foundation

extension String {
    /// Converts a date string from "yyyy-MM-dd" format to "MMMM d, yyyy" format.
    ///
    /// This method takes an input date string in the format "yyyy-MM-dd"
    /// (e.g., "2024-06-11") and returns the date in a more human-readable format
    /// "MMMM d, yyyy" (e.g., "June 11, 2024").
    ///
    /// - Returns: A formatted date string in "MMMM d, yyyy" format if the
    /// conversion is successful, or `nil` if the input string is not in the
    /// expected format.
    ///
    /// Usage:
    /// ```
    /// let dateString = "2024-06-11"
    /// if let formattedDate = dateString.toFormattedDateString() {
    ///     print(formattedDate)  // Output: June 11, 2024
    /// } else {
    ///     print("Invalid date format")
    /// }
    /// ```
    func toFormattedDateString() -> String? {
        // Define the input and output date formatters
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM d, yyyy"

        // Convert the input string to a Date object
        guard let date = inputFormatter.date(from: self) else {
            return nil
        }

        // Convert the Date object back to the desired output string format
        let formattedDate = outputFormatter.string(from: date)
        return formattedDate
    }
}
