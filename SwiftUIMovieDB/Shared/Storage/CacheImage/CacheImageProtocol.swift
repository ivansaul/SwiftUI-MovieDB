//
//  CacheImageProtocol.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/25/24.
//
//  https://github.com/ivansaul
//

import Foundation
import SwiftUI

protocol CacheImageProtocol {
    func save(key: String, value: UIImage) throws
    func get(key: String) -> UIImage?
}
