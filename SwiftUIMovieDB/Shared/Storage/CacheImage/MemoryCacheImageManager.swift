//
//  MemoryCacheImageManager.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/27/24.
//
//  https://github.com/ivansaul
//

import SwiftUI

final class MemoryCacheImageManager: CacheImageProtocol {
    static var shared = MemoryCacheImageManager()

    private init() {}

    private let manager: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 400
        cache.totalCostLimit = 1024 * 1024 * 400 // 200 MB
        return cache
    }()

    func save(key: String, value: UIImage) throws {
        manager.setObject(value, forKey: key as NSString)
    }

    func get(key: String) -> UIImage? {
        manager.object(forKey: key as NSString)
    }
}
