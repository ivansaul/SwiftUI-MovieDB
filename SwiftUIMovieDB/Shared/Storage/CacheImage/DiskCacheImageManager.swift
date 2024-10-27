//
//  DiskCacheImageManager.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/27/24.
//
//  https://github.com/ivansaul
//

import SwiftUI

final class DiskCacheImageManager: CacheImageProtocol {
    static let shared = DiskCacheImageManager()

    private init() {
        cleanExpiredCache()
    }

    private let folderName: String = "TMDB_APP_CACHE"
    private let expirationTime: TimeInterval = 60 * 60 * 24 * 7

    func save(key: String, value: UIImage) throws {
        try createFolderIfNotExist(folderName: folderName)

        guard
            let data = value.pngData(),
            let imageURL = getFileURL(key: key)
        else { return }

        try data.write(to: imageURL)
    }

    func get(key: String) -> UIImage? {
        guard
            let imageURL = getFileURL(key: key),
            FileManager.default.fileExists(atPath: imageURL.path)
        else { return nil }

        return UIImage(contentsOfFile: imageURL.path)
    }

    private func getFileURL(key: String) -> URL? {
        guard let folderURL = getFolderURL(folderName: folderName)
        else { return nil }

        return folderURL.appendingPathComponent(key + ".png")
    }

    private func getFolderURL(folderName: String) -> URL? {
        guard let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }

        return cachesURL.appendingPathComponent(folderName)
    }

    private func createFolderIfNotExist(folderName: String) throws {
        guard let folderURL = getFolderURL(folderName: folderName) else { return }

        if !FileManager.default.fileExists(atPath: folderURL.path) {
            try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
        }
    }

    private func cleanExpiredCache() {
        guard let folderURL = getFolderURL(folderName: folderName) else { return }

        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: [.contentModificationDateKey], options: .skipsHiddenFiles)

            let expirationDate = Date().addingTimeInterval(-expirationTime)
            for fileURL in fileURLs {
                if let attributes = try? FileManager.default.attributesOfItem(atPath: fileURL.path),
                   let modificationDate = attributes[.modificationDate] as? Date,
                   modificationDate < expirationDate
                {
                    try FileManager.default.removeItem(at: fileURL)
                }
            }
        } catch {
            print("DEBUG: Error cleanig disk cache: \(error)")
        }
    }
}
